class RegisterController < ApplicationController
  skip_before_action :check_initial_registration
  skip_before_action :authenticate_user!
  skip_before_action :check_new_year

  before_action :authorize_registration

  layout 'register'

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    require 'securerandom'
    password = User.generate_password
    @user.password = password

    if @user.save
      I18n.locale = @user.language.to_sym
      redirect_to(new_user_session_path, notice: t('controllers.register.success', password: password, default: "The user was successfully created.<br /><br />We've generated a new password for you: <strong>#{password}</strong>"))
    else
      render action: "new"
    end
  end

  private

  def authorize_registration
    redirect_to root_path if current_user || User.count > 0
  end
end
