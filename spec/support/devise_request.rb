module ValidUserRequestHelper
  # Define a method which signs in as a valid user.
  def sign_in_as_a_valid_user
    # ASk factory girl to generate a valid user for us.
    @user1 ||= FactoryGirl.create :user

    # We action the login request using the parameters before we begin.
    # The login requests will match these to the user we just created in the factory, and authenticate us.
    post_via_redirect user_session_path, 'user[email]' => @user1.email, 'user[password]' => @user1.password
  end

  def api_sign_in
    psw = 'qwertyasdfg'
    user = FactoryGirl.create(:user, password: psw)
    post '/api/v1/users/sign_in.json', username: user.email, password: psw
    user
  end
end
