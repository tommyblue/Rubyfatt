class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :token_authenticate_user!, only: :sign_in

  # TODO be compliant with RFC 6749 (OAuth 2.0) http://tools.ietf.org/html/rfc6749
  # See Authenticators paragraph at https://github.com/simplabs/ember-simple-auth
  def sign_in
    raise 'invalid_request' if (params[:username].nil? || params[:password].nil?)
    ip_address = request.remote_ip rescue nil
    if token = User.api_login(params[:username], params[:password], ip_address)
      respond_with({ access_token: token, token_type: 'bearer' }, {location: nil, status: 200})
    else
      respond_with({ error: 'invalid_client', error_description: 'Wrong credentials'}, {location: nil, status: 401 })
    end
  rescue
    respond_with({ error: 'invalid_request', error_description: 'A required parameter is missing or the request is malformed'}, {location: nil, status: 400 })
  end
end
