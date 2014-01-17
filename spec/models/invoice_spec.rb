require 'spec_helper'

describe Invoice do
  it "should be correctly sorted by default" do
    generate_scenario

    invoice1 = @customer.invoices.new date: "2013-01-03", number: 1, consolidated_tax_id: @consolidated_tax.id
    invoice1.slips = [@slip1, @slip2]
    invoice1.save!

    invoice2 = @customer.invoices.new date: "2012-12-03", number: 2, consolidated_tax_id: @consolidated_tax.id
    invoice2.slips = [@slip1, @slip2]
    invoice2.save!

    invoice3 = @customer.invoices.new date: "2012-03-03", number: 4, consolidated_tax_id: @consolidated_tax.id
    invoice3.slips = [@slip1, @slip2]
    invoice3.save!

    invoices = Invoice.where('id IN (?)', [invoice1.id, invoice2.id, invoice3.id])
    invoices[0].id.should eq invoice2.id
    invoices[1].id.should eq invoice3.id
    invoices[2].id.should eq invoice1.id
  end

  it "should be payable" do
    generate_scenario

    invoice = @customer.invoices.new date: "2013-01-03", number: 1, consolidated_tax_id: @consolidated_tax.id, payment_date: nil
    invoice.slips = [@slip1, @slip2]
    invoice.save!

    expect(invoice.paid?).to be_false

    invoice.pay

    expect(invoice.paid?).to be_true
  end

  it "should be payable with specific date" do
    generate_scenario

    invoice = @customer.invoices.new date: "2013-01-03", number: 1, consolidated_tax_id: @consolidated_tax.id, payment_date: nil
    invoice.slips = [@slip1, @slip2]
    invoice.save!

    p_date = 3.weeks.ago.to_date

    invoice.pay(p_date)

    expect(invoice.payment_date).to eq(p_date)
  end

  it "should have a method paid, alias of paid?" do
    generate_scenario

    invoice = @customer.invoices.new date: "2013-01-03", number: 1, consolidated_tax_id: @consolidated_tax.id, payment_date: Time.now
    invoice.slips = [@slip1, @slip2]
    invoice.save!

    expect(invoice.paid?).to be_true

    invoice.update_attribute(:payment_date, nil)
    expect(invoice.paid?).to be_false
  end

  it "should be paid if has a payment date" do
    generate_scenario

    invoice = @customer.invoices.new date: "2013-01-03", number: 1, consolidated_tax_id: @consolidated_tax.id, payment_date: Time.now
    invoice.slips = [@slip1, @slip2]
    invoice.save!

    expect(invoice.paid?).to be_true
  end

  it "should be unpaid if hasn't a payment date" do
    generate_scenario

    invoice = @customer.invoices.new date: "2013-01-03", number: 1, consolidated_tax_id: @consolidated_tax.id, payment_date: nil
    invoice.slips = [@slip1, @slip2]
    invoice.save!

    expect(invoice.paid?).to be_false
  end
end
