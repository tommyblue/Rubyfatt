class OptionsController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    @options= current_user.options
  end
  
  def edit
    @option = Option.find(params[:id])
  end

  def update
    @option = Option.find(params[:id])
    if @option.update_attributes(params[:option])
      redirect_to(options_path, :notice => t('controllers.options.update.success', :default => 'The option was successfully updated.'))
    else
      render :action => "edit"
    end
  end
end
