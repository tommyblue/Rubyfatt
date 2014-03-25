require 'spec_helper'

describe "Invoices requests" do
  before do
    @user = api_sign_in
    @customer = FactoryGirl.create :customer_with_invoices, user: @user
  end

  describe "GET #index" do
    it "respond correctly" do
      get "api/v1/invoices.json", nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      expect(response).to be_success
    end

    it "assigns @invoices" do
      get 'api/v1/invoices.json', nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      expect(assigns(:invoices)).to eq(@customer.invoices.to_a)
    end

    it "return @invoices as json" do
      get 'api/v1/invoices.json', nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      json = JSON.parse(response.body)
      expect(json['invoices'].length).to eq(3)
    end
  end

  describe "GET #index filtered by YEAR" do
    it "respond correctly" do
      get "api/v1/invoices/year/#{Time.now.year}.json", nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      expect(response).to be_success
    end

    it "Accepts only 4-digit year number #1" do
      expect { get "api/v1/invoices/year/#{Time.now.year}1.json", nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token} }.to raise_error(ActionController::RoutingError)
    end

    it "Accepts only 4-digit year number #2" do
      expect { get "api/v1/invoices/year/ABC.json", nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token} }.to raise_error(ActionController::RoutingError)
    end

    it "assigns @invoices" do
      get 'api/v1/invoices.json', nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      expect(assigns(:invoices)).to eq(@customer.invoices.to_a)
    end

    it "return @invoices as json" do
      get 'api/v1/invoices.json', nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      json = JSON.parse(response.body)
      expect(json['invoices'].length).to eq(3)
    end
  end
end

