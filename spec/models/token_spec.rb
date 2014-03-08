require 'spec_helper'

describe Token do
  it "consider a token as invalid if older than 1 week" do
  end

  it "returns a new token at request" do
    expect(Token.generate_token).to be_kind_of(String)
  end
end
