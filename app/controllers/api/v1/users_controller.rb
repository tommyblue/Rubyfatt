class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :token_authenticate_user!, only: :sign_in

  def sign_in
    if token = User.api_login(params[:user][:email], params[:user][:password])
      respond_with({ token: token }, {location: nil, status: 200})
    else
      respond_with({ error: 'wrong credentials'}, {location: nil, status: 401 })
    end
  end
end
