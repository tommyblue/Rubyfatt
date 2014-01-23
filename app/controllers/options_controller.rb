class OptionsController < ApplicationController
  load_and_authorize_resource

  def index
    @available_options = Option::DEFAULT_VALUES.map{ |e| e[:name] } - Option.all.map(&:name)
  end

  def create
    unless params[:option][:name].blank?
      Option.create_option(current_user, params[:option][:name])
      flash[:notice] = t('controllers.options.create.success', default: 'The option was correctly created')
    else
      flash[:error] = t('controllers.options.create.error', default: "Error creating the new option")
    end
    redirect_to options_path
  end

  def save
    params[:options].each_pair do |name, value|
      if option = current_user.options.find_by_name(name)
        value = value.to_i if option.integer
        option.update_attribute(:value, value)
      end
    end
    redirect_to options_path, notice: t('controllers.options.update.success', default: "Options was successfully updated")
  end
end
