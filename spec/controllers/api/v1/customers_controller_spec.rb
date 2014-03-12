require 'spec_helper'

describe Api::V1::CustomersController do
  context ":create" do
    it "successfully create a customer" do
      user = FactoryGirl.create :user_with_token
      @request.env['HTTP_AUTHORIZATION'] = user.tokens.last.token
      expect {
        post :create, customer: FactoryGirl.attributes_for(:customer, user: user), format: :json
      }.to change(user.customers, :count).by(1)
    end

    it "does not create an invalid customer" do
      user = FactoryGirl.create :user_with_token
      @request.env['HTTP_AUTHORIZATION'] = user.tokens.last.token
      expect{
        post :create, format: :json, customer: FactoryGirl.attributes_for(:customer, user: user, title: nil)
      }.to_not change(user.customers, :count)
    end

    it "ignore user_id and uses the current_user" do
      user = FactoryGirl.create :user_with_token
      bad_user = FactoryGirl.create :user
      customer = FactoryGirl.attributes_for(:customer, user: bad_user, id: 123)
      @request.env['HTTP_AUTHORIZATION'] = user.tokens.last.token
      post :create, format: :json, customer: customer
      json = JSON.parse(response.body)
      expect(json['customer']['user_id']).to eq(user.id)
    end
  end

  context ":update" do
    it "updates a valid customer" do
      user = FactoryGirl.create :user_with_token
      customer = FactoryGirl.create :customer, user: user, title: 'asdfgh', vat: 654321
      @request.env['HTTP_AUTHORIZATION'] = user.tokens.last.token
      put :update, format: :json, id: customer.id, customer: FactoryGirl.attributes_for(:customer, title: 'qwerty', vat: '123456')
      expect(response.status).to eq(204)
      customer.reload
      expect(customer.title).to eq('qwerty')
      expect(customer.vat).to eq('123456')
    end

    it "does not update an invalid customer" do
      user = FactoryGirl.create :user_with_token
      customer = FactoryGirl.create :customer, user: user, title: 'qwerty', vat: '123456'
      @request.env['HTTP_AUTHORIZATION'] = user.tokens.last.token
      put :update, id: customer.id, customer: FactoryGirl.attributes_for(:customer, title: nil, vat: '654321'), format: :json
      expect(response.status).to eq(422)
      customer.reload
      expect(customer.title).to eq('qwerty')
      expect(customer.vat).to eq('123456')
    end

    it "does not update a customer with wrong user" do
      user = FactoryGirl.create :user_with_token
      customer = FactoryGirl.create :customer, user: user
      bad_user = FactoryGirl.create :user
      @request.env['HTTP_AUTHORIZATION'] = user.tokens.last.token
      expect{
        put :update, format: :json, id: customer.id, customer: FactoryGirl.attributes_for(:customer, user: bad_user)
      }.to_not change(Customer,:count)
    end
  end

  context ':destroy' do
    it "successfully delete a customer" do
      user = FactoryGirl.create :user_with_token
      customer = FactoryGirl.create :customer, user: user
      @request.env['HTTP_AUTHORIZATION'] = user.tokens.last.token
      expect {
        delete :destroy, id: customer.id
      }.to change(user.customers, :count).by(-1)
    end
  end
end
