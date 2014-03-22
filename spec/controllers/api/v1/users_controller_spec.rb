require 'spec_helper'

describe Api::V1::UsersController do
  describe 'Manage user login' do
    it 'can sign in receiving the token' do
      psw = 'qwertyasdfg'
      user = FactoryGirl.create(:user, password: psw)
      post :sign_in, format: :json, username: user.email, password: psw
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['access_token']).to eq(user.tokens.last.token)
    end

    it 'needs username and password to sign in' do
      user = FactoryGirl.create(:user)
      post :sign_in, format: :json, usename: user.email
      expect(response.response_code).to eq(400)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('invalid_request')
    end

    it 'can\'t sign with wrong credentials' do
      psw = 'qwertyasdfg'
      user = FactoryGirl.create(:user, password: psw)
      post :sign_in, format: :json, username: user.email, password: "123456"
      expect(response.response_code).to eq(401)
      json = JSON.parse(response.body)
      expect(json['error']).to eq('invalid_client')
    end
  end
end
