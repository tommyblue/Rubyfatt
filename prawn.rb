require 'prawn'
require 'date'

pdf = Prawn::Document.new

pdf.font "Helvetica"

# Defining the grid 
# See http://prawn.majesticseacreature.com/manual.pdf
pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10) 

pdf.grid([0,0], [1,1]).bounding_box do 
  pdf.text  "INVOICE", :size => 18
  pdf.text "Invoice No: 0001", :align => :left
  pdf.text "Date: #{Date.today.to_s}", :align => :left
  pdf.move_down 10
  
  pdf.text "Attn: To whom it may concern "
  pdf.text "Company Name"
  pdf.text "Tel No: 1"
  pdf.text "Fax No: 0`  1"
end

pdf.grid([0,3.6], [1,4]).bounding_box do 
  # Assign the path to your file name first to a local variable.
  logo_path = File.expand_path('../lib/assets/images/logo-notule.png', __FILE__)

  # Displays the image in your PDF. Dimensions are optional.
  pdf.image logo_path, :width => 137, :height => 60, :position => :left

  # Company address
  pdf.move_down 10
  pdf.text "Awesomeness Ptd Ltd", :align => :left
  pdf.text "Address", :align => :left
  pdf.text "Street 1", :align => :left
  pdf.text "40300 Shah Alam", :align => :left
  pdf.text "Selangor", :align => :left
  pdf.text "Tel No: 42", :align => :left
  pdf.text "Fax No: 42", :align => :left
end

pdf.text "Details of Invoice", :style => :bold_italic
pdf.stroke_horizontal_rule


temp_arr = [{:name => 'Unit 1', :price => "10.00"},
            {:name => 'Unit 2', :price => "12.00"}]

pdf.move_down 10
items = [["No","Description", "Qt.", "RM"]]
items += temp_arr.each_with_index.map do |item, i|
  [
    i + 1,
    item[:name],
    "1",
    item[:price],
  ]
end
items += [["", "Total", "", "22.00"]]


pdf.table items, :header => true, 
  :column_widths => { 0 => 50, 1 => 350, 3 => 100}, :row_colors => ["d2e3ed", "FFFFFF"] do
    style(columns(3)) {|x| x.align = :right }
end


pdf.move_down 40
pdf.text "Terms & Conditions of Sales"
pdf.text "1.	All cheques should be crossed and made payable to Awesomeness Ptd Ltd"

pdf.move_down 40
pdf.text "Received in good condition", :style => :italic

pdf.move_down 20
pdf.text "..............................."
pdf.text "Signature/Company Stamp"

pdf.move_down 10
pdf.stroke_horizontal_rule

pdf.bounding_box([pdf.bounds.right - 50, pdf.bounds.bottom], :width => 60, :height => 20) do
  pagecount = pdf.page_count
  pdf.text "Page #{pagecount}"
end

pdf.render_file "invoice.pdf"