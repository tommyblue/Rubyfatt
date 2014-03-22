require 'spec_helper'

describe "API interface" do
  before do
    @user = api_sign_in
    @customer1 = FactoryGirl.create :customer, user: @user
  end

  describe "404 errors are correctly managed" do
    it "respond with 404" do
      get "api/v1/customers/100.json", nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      expect(response.status).to eq(404)
    end

    it "return the correct error" do
      get 'api/v1/customers/100.json', nil, {'HTTP_AUTHORIZATION' =>  @user.tokens.last.token}
      json = JSON.parse(response.body)
      expect(json['error']).to eq('not_found')
    end
  end

  describe "unauthorized requests are correctly managed" do
    it "respond with 401" do
      get "api/v1/customers/100.json"
      expect(response.status).to eq(401)
    end

    it "return the correct error" do
      get 'api/v1/customers/100.json'
      json = JSON.parse(response.body)
      expect(json['error']).to eq('unauthorized')
    end
  end
end

