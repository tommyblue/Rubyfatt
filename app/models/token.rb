class Token < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true, uniqueness: true

  # Defines a token as valid if newer than 1 week
  def is_valid?
    (Time.now - self.created_at) < 1.week
  end

  # Generate a new, unique, token
  def self.generate_token
    loop do
      token = Devise.friendly_token
      break token unless Token.where(token: token).first
    end
  end
end
