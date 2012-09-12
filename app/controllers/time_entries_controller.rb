class TimeEntriesController < ApplicationController
  load_and_authorize_resource :customer
  load_and_authorize_resource :slip, :through => :customer
  load_and_authorize_resource :time_entry, :through => :slip

  def new
  end

  def create
    @time_entry = @slip.time_entries.new(params[:time_entry])
    if @time_entry.save
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.time_entries.create.success', :default => 'The time entry was successfully created.'))
    else
      render :action => :new
    end
  end

  def destroy
    if @time_entry.destroy
      flash[:notice] = t('controllers.time_entries.destroy.success', :default => "Time entry deleted")
    else
      flash[:error] = t('controllers.time_entries.destroy.error', :default => "Error deleting the time entry")
    end
    redirect_to :back
  end
end
