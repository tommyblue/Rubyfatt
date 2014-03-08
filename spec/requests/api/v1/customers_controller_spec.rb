require 'spec_helper'
describe "CustomersController" do
  describe "GET #index" do
    it "respond correctly" do
      generate_scenario
      get 'api/v1/customers.json'
      expect(response).to be_success
    end

    it "assigns @customers" do
      generate_scenario
      get 'api/v1/customers.json'
      expect(assigns(:customers)).to eq([@customer1, @customer2])
    end

    it "return @customers as json" do
      generate_scenario
      get 'api/v1/customers.json'
      json = JSON.parse(response.body)
      expect(json['customers'].length).to eq(2)
    end
  end
end
