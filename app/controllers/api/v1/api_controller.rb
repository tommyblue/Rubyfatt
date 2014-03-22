class Api::V1::ApiController < ActionController::Base
  include Pundit
  protect_from_forgery with: :null_session
  respond_to :json

  before_action :token_authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_with({ error: 'not_found', error_description: 'The requested resource was not found'}, {location: nil, status: 404 })
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
    respond_with({error: 'unauthorized', error_description: 'This request needs a valid authorization token'}, {location: nil, status: 401 })
  end

  def current_user
    @user
  end

  private

  def token_authenticate_user!
    token = request.headers["HTTP_AUTHORIZATION"].gsub('Bearer ', '') rescue nil
    raise Pundit::NotAuthorizedError, 'invalid_client' unless !token.blank? && @user = User.authenticate_with_token(token)
  end
end
