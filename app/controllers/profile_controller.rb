class ProfileController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      sign_in @user, :bypass => true
      redirect_to(root_path, :notice => 'Your profile was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  def password_edit
    @user = current_user
  end

  def password_update
    @user = current_user
    if @user.update_attributes(params[:user])
      sign_in @user, :bypass => true
      redirect_to(root_path, :notice => 'Your password was successfully updated.')
    else
      render :action => "password_edit"
    end
  end
end
