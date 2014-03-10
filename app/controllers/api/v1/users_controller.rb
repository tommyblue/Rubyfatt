class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :token_authenticate_user!, only: :sign_in

  # TODO be compliant with RFC 6749 (OAuth 2.0) http://tools.ietf.org/html/rfc6749
  # See Authenticators paragraph at https://github.com/simplabs/ember-simple-auth
  def sign_in
    if token = User.api_login(params[:username], params[:password])
      respond_with({ access_token: token, token_type: 'bearer' }, {location: nil, status: 200})
    else
      respond_with({ error: 'wrong credentials'}, {location: nil, status: 401 })
    end
  rescue
    respond_with({ error: 'wrong credentials'}, {location: nil, status: 401 })
  end
end
