require 'spec_helper'

describe Token do
  it "consider a token as valid if newer than 1 week" do
    @user = FactoryGirl.create :user
    @token = @user.tokens.create(created_at: 1.week.ago+60)
    expect(@token.is_valid?).to be true
  end

  it "consider a token as invalid if older than 1 week" do
    @user = FactoryGirl.create :user
    @token = @user.tokens.create(created_at: 1.week.ago)
    expect(@token.is_valid?).to be false
  end

  it "returns a new token at request" do
    expect(Token.generate_token).to be_kind_of(String)
  end

  it "automatically sets a unique token on creation" do
    @user = FactoryGirl.create :user
    token = @user.tokens.create
    expect(token.token).to be_kind_of(String)
  end
end
