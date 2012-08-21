class OptionsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def edit
  end

  def update
    if @option.update_attributes(params[:option])
      redirect_to(options_path, :notice => t('controllers.options.update.success', :default => 'The option was successfully updated.'))
    else
      render :action => "edit"
    end
  end
end
