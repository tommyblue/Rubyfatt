class OptionsController < ApplicationController
  load_and_authorize_resource

  def index
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
