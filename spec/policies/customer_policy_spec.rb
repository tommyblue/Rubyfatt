require 'spec_helper'

describe CustomerPolicy do
  subject { CustomerPolicy }

  context "for current user" do
    it "can only see its customers" do
      generate_scenario
      expect(CustomerPolicy::Scope.new(@user1, Customer).resolve).to eq([@customer1, @customer2])
    end

    it "can't see others' customers" do
      generate_scenario
      expect(CustomerPolicy::Scope.new(@user1, Customer).resolve).not_to include(@customer3)
    end
  end
end
