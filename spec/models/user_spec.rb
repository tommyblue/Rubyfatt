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
    expect{@user.tokens.create}.to change{@user.tokens.count}.by(1)
  end

  it "returns a new token when correctly logged-in" do
    token = User.api_login @user.email, "12345678"
    expect(token).to eq(@user.tokens.last.token)
  end

  describe "Can receive the user last token" do
    it "has a token method to retrieve the last token" do
      user = FactoryGirl.create :user_with_token
      expect(user.token).to eq(user.tokens.last.token)
    end

    it "receive nil if the user doesn't have a token" do
      user = FactoryGirl.create :user
      expect(user.token).to be_nil
    end
end
end
