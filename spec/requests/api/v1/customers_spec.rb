require 'spec_helper'

describe "CustomersController" do
  before do
    @user = api_sign_in
    @customer1 = FactoryGirl.create :customer, user: @user
    @customer2 = FactoryGirl.create :customer, user: @user
  end

  describe "GET #index" do
    it "respond correctly" do
      get "api/v1/customers.json", nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      expect(response).to be_success
    end

    it "assigns @customers" do
      get 'api/v1/customers.json', nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      expect(assigns(:customers)).to eq([@customer1, @customer2])
    end

    it "return @customers as json" do
      get 'api/v1/customers.json', nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      json = JSON.parse(response.body)
      expect(json['customers'].length).to eq(2)
    end
  end
end
