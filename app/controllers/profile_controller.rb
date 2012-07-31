class ProfileController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      sign_in @user, :bypass => true
      redirect_to(edit_profile_path, :notice => t('controllers.profile.update.success', :default => 'Your profile was successfully updated.'))
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
      redirect_to(root_path, :notice => t('controllers.profile.password_update.success', :default => 'Your password was successfully updated.'))
    else
      render :action => "password_edit"
    end
  end
end
