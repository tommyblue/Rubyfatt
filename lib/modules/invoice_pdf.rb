require 'prawn'
include ActionView::Helpers::NumberHelper
class InvoicePdf < Prawn::Document
  def initialize(invoice, view, title = "Notula", bank_coordinates = nil)
    super()
    title ||= "Notula"
    @title = title
    @bank_coordinates = bank_coordinates
    @invoice = invoice
    @view = view
    @subtotal = 0.0

    self.setup
    self.draw_pdf
  end

  def draw_pdf
    self.header()

    move_down 10

    self.slips()

    move_down 50

    self.consolidated_taxes()
    self.bank_coordinates if @bank_coordinates
    self.print_total
  end

  def setup
    font_families.update(
      "LiberationSans" => {
        normal: "#{Rails.root}/lib/assets/fonts/LiberationSans-Regular.ttf",
        bold:   "#{Rails.root}/lib/assets/fonts/LiberationSans-Bold.ttf"
      }
    )
    font "LiberationSans", size: 12
    define_grid(columns: 5, rows: 8, gutter: 10)
  end

  ## Header
  def header
    self.header_left
    self.header_right
    self.header_bottom
  end

  def header_left
    grid([0,0], [1,2]).bounding_box do
      move_down 50
      text "Attenzione:", color: "777777"
      text "#{@invoice.customer.heading}", color: "5569A3"
      text "#{@invoice.customer.address}", color: "5569A3"
      province =  @invoice.customer.province.blank? ? '' : " (#{@invoice.customer.province})"
      text "#{@invoice.customer.zip_code} #{@invoice.customer.town}#{province}", color: "5569A3"
      text "C.F. #{@invoice.customer.tax_code}", color: "5569A3" unless @invoice.customer.tax_code.blank?
      text "P.IVA #{@invoice.customer.vat}", color: "5569A3" unless @invoice.customer.vat.blank?
    end
  end

  def header_right
    grid([0,3.4], [2,4]).bounding_box do

      self.logo

      move_down 10

      self.company_address
    end
  end

  def header_bottom
    grid([2,0], [2,1]).bounding_box do
      text  @title, size: 24, style: :bold, color: "5569A3"
      text "#{@invoice.customer.user.town}, #{@invoice.date.strftime("%d/%m/%Y")}", align: :left, color: "5569A3"
      text "#{@title} n. #{@invoice.date.year}-#{@invoice.number.to_s.rjust(3,'0')}", align: :left, color: "5569A3"
    end
  end

  def logo
    if @invoice.customer.user.logo.present?
      logopath =  @invoice.customer.user.logo.path
      image logopath, width: 137, height: 60
    end
  end

  def bank_coordinates
    grid([7,0], [8,1]).bounding_box do
      text "Coordinate bancarie", align: :left, style: :bold, color: "5569A3"
      text "#{@bank_coordinates}", align: :left, color: "5569A3"
    end
  end

  def company_address
      text "#{@invoice.customer.user.surname} #{@invoice.customer.user.name}", align: :left, color: "777777"
      text "#{@invoice.customer.user.address}", align: :left, color: "777777"
      text "#{@invoice.customer.user.zip_code} #{@invoice.customer.user.town} (#{@invoice.customer.user.province})", align: :left, color: "777777"
      text "C.F. #{@invoice.customer.user.tax_code}", align: :left, color: "777777"
      text "P.IVA #{@invoice.customer.user.vat}", align: :left, color: "777777"
      text "#{@invoice.customer.user.email}", align: :left, color: "777777"
      text "#{@invoice.customer.user.phone}", align: :left, color: "777777"
  end

  ## Slips
  def slips
    items = [["<color rgb='5569A3'>Oggetto</color>", "<color rgb='5569A3'>Subtotale</color>"]]

    @invoice.slips.each do |slip|
      @subtotal += slip.rate
      items += [["<color rgb='777777'>#{slip.name}</color>", "<color rgb='777777'>#{number_to_currency(slip.rate)}</color>"]]
    end

    table items, header: true, width: 500, position: :right,
      cell_style: { overflow: :shrink_to_fit, borders: [:bottom], border_width: 1, border_color: "5569A3", inline_format: true },
      column_widths: { 0 => 400, 1 => 100} do
        style(columns(2)) {|x| x.align = :right }
        row(0).borders = []
        row(0).font_style = :bold
    end
  end

  ## Consolidated taxes
  def consolidated_taxes
    items = [["<b>Subtotale</b>", "<b>#{number_to_currency(@subtotal)}</b>"]]

    items = self.calculate_total(items)

    items += [["<b>Totale</b>", "<b>#{number_to_currency(@sum)}</b>"]]

    grid([5,2], [6,4]).bounding_box do
      table items, header: false, width: 250, position: :right,
        cell_style: { align: :right, borders: [], inline_format: true, overflow: :shrink_to_fit, text_color: "5569A3" },
        column_widths: { 0 => 150, 1 => 100} do
          style(columns(2)) {|x| x.align = :right }
      end
    end

    grid([7,3], [8,4]).bounding_box do
      text(@invoice.consolidated_tax.notes, align: :right, color: "777777") if @invoice.consolidated_tax.notes
    end
  end

  # TODO: this method, except for the line which adds the strings to `items`, is the same than Calculators::TaxCalculator#total
  def calculate_total(items)
    @sum = @subtotal
    compounds = []

    taxes = @invoice.consolidated_tax.taxes
    taxes.each_with_index do |tax, index|
      if tax.fixed_rate
        partial = tax.rate
      else
        partial = @sum * tax.rate / 100
      end

      items += [[tax.name, number_to_currency(partial)]]

      if tax.compound
        compounds << partial
      else
        compounds.each { |compound| @sum += compound }
        @sum += partial
        items += [["<b>Imponibile</b>", "<b>#{number_to_currency(@sum)}</b>"]] if taxes.size > index + 1 && taxes[index + 1].compound
      end
    end

    compounds.each { |compound| @sum += compound }

    items
  end

  def print_total
    grid([2,3], [2,4]).bounding_box do
      move_down 30
      text  "#{number_to_currency(@sum)}", size: 24, style: :bold, color: "5569A3", align: :right
    end
  end
end
