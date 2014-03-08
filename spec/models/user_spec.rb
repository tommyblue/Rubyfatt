require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.create :user, { password: "12345678" }
  end

  # Probably useless, `valid_password?` is a Devise method
  it "permit to check the password accuracy" do
    expect(@user.valid_password?("12345678")).to be true
  end

  it "can create a new token for the user" do
    expect{@user.new_token}.to change{@user.tokens.count}.by(1)
  end

  it "returns a new token when correctly logged-in" do
    token = User.api_login @user.email, "12345678"
    expect(token).to eq(@user.tokens.last.token)
  end
end
