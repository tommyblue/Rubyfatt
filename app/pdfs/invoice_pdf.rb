require 'prawn'
include ActionView::Helpers::NumberHelper
class InvoicePdf < Prawn::Document
  def initialize(invoice, view)
    super()
    @invoice = invoice
    @view = view
    @subtotal = 0.0
    self.setup()
    self.header()
    move_down 10
    self.slips()
    move_down 50
    self.consolidated_taxes()
    self.print_total
    #grid.show_all
  end
  
  # Initial setup
  def setup
    #font "#{Rails.root}/lib/assets/fonts/Neuton.ttf"
    font_families.update(
      "LiberationSans" => {
        :normal => "#{Rails.root}/lib/assets/fonts/LiberationSans-Regular.ttf",
        :bold   => "#{Rails.root}/lib/assets/fonts/LiberationSans-Bold.ttf"
      }
    )
    font "LiberationSans", :size => 12
    define_grid(:columns => 5, :rows => 8, :gutter => 10) 
  end
  
  ## Header
  def header
    self.header_left
    self.header_right
    self.header_bottom
  end
  
  def header_bottom
    grid([2,0], [2,1]).bounding_box do 
      text  "Notula", :size => 24, :style => :bold, :color => "5569A3"
      text "#{@invoice.customer.user.town}, #{@invoice.date.strftime("%d/%m/%Y")}", :align => :left, :color => "5569A3"
      text "Notula n. #{@invoice.date.year}-#{@invoice.number.to_s.rjust(3,'0')}", :align => :left, :color => "5569A3"
    end
  end

  def header_left
    grid([0,0], [1,1]).bounding_box do 
      move_down 50
      text "Attenzione:", :color => "777777"
      if @invoice.customer.title
        text "#{@invoice.customer.title}", :color => "5569A3"
      else
        text "#{@invoice.customer.surname} #{@invoice.customer.name}", :color => "5569A3"
      end
      text "#{@invoice.customer.address}", :color => "5569A3"
      province =  @invoice.customer.province == '' ? '' : " (#{@invoice.customer.province})"
      text "#{@invoice.customer.zip_code} #{@invoice.customer.town}#{province}", :color => "5569A3"
      text "C.F. #{@invoice.customer.tax_code}", :color => "5569A3" if @invoice.customer.tax_code != ''
      text "P.IVA #{@invoice.customer.vat}", :color => "5569A3" if @invoice.customer.vat != ''
    end
  end
  
  def header_right
    grid([0,3.4], [2,4]).bounding_box do 
      
      # Logo
      self.logo()

      # Company address
      move_down 10
      text "#{@invoice.customer.user.surname} #{@invoice.customer.user.name}", :align => :left, :color => "777777"
      text "#{@invoice.customer.user.address}", :align => :left, :color => "777777"
      text "#{@invoice.customer.user.zip_code} #{@invoice.customer.user.town} (#{@invoice.customer.user.province})", :align => :left, :color => "777777"
      text "C.F. #{@invoice.customer.user.tax_code}", :align => :left, :color => "777777"
      text "P.IVA #{@invoice.customer.user.vat}", :align => :left, :color => "777777"
      text "#{@invoice.customer.user.email}", :align => :left, :color => "777777"
      text "#{@invoice.customer.user.phone}", :align => :left, :color => "777777"
    end
  end
  
  ## Logo
  def logo
    logopath =  "#{Rails.root}/lib/assets/images/logo-notule.png"
    image logopath, :width => 137, :height => 60
  end
  
  ## Slips
  def slips    
    items = [["<color rgb='5569A3'>Oggetto</color>", "<color rgb='5569A3'>Subtotale</color>"]]
    
    @invoice.slips.each do |slip|
      @subtotal += slip.rate
      items += [["<color rgb='777777'>#{slip.name}</color>", "<color rgb='777777'>#{number_to_currency(slip.rate)}</color>"]]
    end
    
    table items, :header => true, :width => 500, :position => :right, 
      :cell_style => { :overflow => :shrink_to_fit, :borders => [:bottom], :border_width => 1, :border_color => "5569A3", :inline_format => true },
      :column_widths => { 0 => 400, 1 => 100} do
        style(columns(2)) {|x| x.align = :right }
        row(0).borders = []
        row(0).font_style = :bold
    end
  end
  
  ## Consolidated taxes
  def consolidated_taxes
    items = [["<b>Subtotale</b>", "<b>#{number_to_currency(@subtotal)}</b>"]]
    
    @sum = @subtotal
    compounds = []
    
    @invoice.consolidated_tax.taxes.each do |tax|
      partial = @sum * tax.rate / 100
      items += [[tax.name, number_to_currency(partial)]]
      
      if tax.compound
        compounds << partial
      else
        compounds.each { |compound| @sum += compound }
        @sum += partial
        items += [["<b>Imponibile</b>", "<b>#{number_to_currency(@sum)}</b>"]]
      end
    end
    
    compounds.each { |compound| @sum += compound }
    
    items += [["<b>Totale</b>", "<b>#{number_to_currency(@sum)}</b>"]]
    
    grid([5,2], [6,4]).bounding_box do 
      table items, :header => false, :width => 250, :position => :right,
        :cell_style => { :align => :right, :borders => [], :inline_format => true, :overflow => :shrink_to_fit, :text_color => "5569A3" },
        :column_widths => { 0 => 150, 1 => 100} do
          style(columns(2)) {|x| x.align = :right }
      end
    end
  end
  
  def print_total
    grid([2,3], [2,4]).bounding_box do 
      move_down 30
      text  "#{number_to_currency(@sum)}", :size => 24, :style => :bold, :color => "5569A3", :align => :right
    end
  end
end