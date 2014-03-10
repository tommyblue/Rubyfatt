class Api::V1::ApiController < ActionController::Base
  include Pundit
  protect_from_forgery with: :null_session
  respond_to :json

  before_action :token_authenticate_user!

  def current_user
    @user
  end

  private

  def token_authenticate_user!
    token = request.headers["HTTP_AUTHORIZATION"].gsub('Bearer ', '') rescue nil
    respond_with({error: "unauthorized"}, {location: nil, status: 401 }) unless !token.blank? && @user = User.authenticate_with_token(token)
  end
end
