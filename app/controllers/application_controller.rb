class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  before_action :set_locale
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to root_url, :alert => exception.message
  end

  protected

  def set_locale
    if current_user
      I18n.locale = current_user.language.to_sym || I18n.default_locale
    else
      I18n.default_locale
    end
  end

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end
end
