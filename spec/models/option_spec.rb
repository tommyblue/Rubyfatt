require 'spec_helper'

describe Option do
  it "should inscrement by 1 the option number when an Estimate is created" do
    generate_scenario
    old_number = Option.get_option(@user, Estimate.next_option_name).value.to_i

    @estimate = Estimate.new(date: Time.now)
    @estimate.consolidated_tax = @consolidated_tax
    @estimate.customer = @customer1
    @estimate.slips = [@slip1, @slip2]
    @estimate.save!

    new_number = Option.get_option(@user, Estimate.next_option_name).value.to_i

    expect(new_number).to eq(old_number + 1)
  end

  it "should inscrement by 1 the option number when an InvoiceProject is created" do
    generate_scenario
    old_number = Option.get_option(@user, InvoiceProject.next_option_name).value.to_i

    @invoice_project = InvoiceProject.new(date: Time.now)
    @invoice_project.consolidated_tax = @consolidated_tax
    @invoice_project.customer = @customer1
    @invoice_project.slips = [@slip1, @slip2]
    @invoice_project.save!

    new_number = Option.get_option(@user, InvoiceProject.next_option_name).value.to_i

    expect(new_number).to eq(old_number + 1)
  end

  it "should inscrement by 1 the option number when an Invoice is created" do
    generate_scenario
    old_number = Option.get_option(@user, Invoice.next_option_name).value.to_i

    @invoice = Invoice.new(date: Time.now)
    @invoice.consolidated_tax = @consolidated_tax
    @invoice.customer = @customer1
    @invoice.slips = [@slip1, @slip2]
    @invoice.save!

    new_number = Option.get_option(@user, Invoice.next_option_name).value.to_i

    expect(new_number).to eq(old_number + 1)
  end

end
