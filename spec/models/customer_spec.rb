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
end
