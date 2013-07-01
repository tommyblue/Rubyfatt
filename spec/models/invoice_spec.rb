require 'spec_helper'

describe Invoice do
  it "should be correctly sorted by default" do
    generate_scenario

    invoice1 = @customer.invoices.new date: "2013-01-03", number: 1, paid: false, consolidated_tax_id: @consolidated_tax.id
    invoice1.slips = [@slip1, @slip2]
    invoice1.save!

    invoice2 = @customer.invoices.new date: "2012-12-03", number: 2, paid: false, consolidated_tax_id: @consolidated_tax.id
    invoice2.slips = [@slip1, @slip2]
    invoice2.save!

    invoice3 = @customer.invoices.new date: "2012-03-03", number: 4, paid: false, consolidated_tax_id: @consolidated_tax.id
    invoice3.slips = [@slip1, @slip2]
    invoice3.save!

    invoices = Invoice.where('id IN (?)', [invoice1.id, invoice2.id, invoice3.id])
    invoices[0].id.should eq invoice2.id
    invoices[1].id.should eq invoice3.id
    invoices[2].id.should eq invoice1.id
  end
end
