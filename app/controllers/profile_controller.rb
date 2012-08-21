class ProfileController < ApplicationController
  before_filter :load_current_user
  authorize_resource :user, :parent => false

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      sign_in @user, :bypass => true
      redirect_to(edit_profile_path, :notice => t('controllers.profile.update.success', :default => 'Your profile was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def password_edit
  end

  def password_update
    if @user.update_attributes(params[:user])
      sign_in @user, :bypass => true
      redirect_to(root_path, :notice => t('controllers.profile.password_update.success', :default => 'Your password was successfully updated.'))
    else
      render :action => "password_edit"
    end
  end

  private
    def load_current_user
      @user = current_user
    end
end
