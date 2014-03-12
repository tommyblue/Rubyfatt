require 'spec_helper'

describe Customer do
  it "can show customers ordered by title, name, surname" do
    user = FactoryGirl.create :user

    c1 = FactoryGirl.create :customer, { title: "b" }
    c2 = FactoryGirl.create :customer, { title: "c" }
    c3 = FactoryGirl.create :customer, { title: "a" }
    user.customers = [c1,c2,c3]

    expect(user.customers.ordered).to eq([c3,c1,c2])
  end

  it "can be deleted if doesn't have relationships" do
    user = FactoryGirl.create :user
    customer = FactoryGirl.create :customer, user: user
    expect(customer.can_be_deleted?).to be true
    customer.destroy
    expect(customer.destroyed?).to be true
  end

  it "can't be deleted if can_be_deleted? returns false" do
    user = FactoryGirl.create :user
    customer = FactoryGirl.create :customer, user: user
    slip = FactoryGirl.create :slip, customer: customer
    expect(customer.can_be_deleted?).to be false
    expect(customer.destroy).to be_instance_of(Customer)
  end
end
