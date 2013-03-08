class CertificationsController < ApplicationController
  load_and_authorize_resource

  def index
    @year_certifications = Certification.year_certification(current_user, Time.now.year-1)
  end

  def edit
  end

  def update
    # To be sure to don't mess certification
    params[:certification].delete(:rate)
    params[:certification].delete(:year)

    if @certification.update_attributes(params[:certification])
      redirect_to(certifications_path, notice: t('controllers.certifications.update.success', default: 'The certification was successfully updated.'))
    else
      render :action => "edit"
    end
  end
end
