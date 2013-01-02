class RecurringSlipsController < ApplicationController
  load_and_authorize_resource

  def index
    @recurring_slips = @recurring_slips.order('next_occurrence ASC').all
  end

  def show
  end

  def new
  end

  def create
    rule = IceCube::Rule.monthly(params[:schedule][:month].to_i).day_of_month(params[:schedule][:day].to_i)
    schedule = IceCube::Schedule.new
    schedule.add_recurrence_rule rule
    @recurring_slip.schedule = schedule
    next_occurrence = params[:schedule][:next].empty? ? nil : Date.strptime(params[:schedule][:next], "%d/%m/%Y")
    @recurring_slip.start_date = next_occurrence if next_occurrence
    if @recurring_slip.save
      @recurring_slip.force_next_occurrence(next_occurrence) if next_occurrence
      redirect_to(recurring_slips_path, :notice => t('controllers.recurring_slips.create.success', :default => 'The recurring slip was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @recurring_slip.update_attributes(params[:recurring_slip])
      @recurring_slip.force_next_occurrence(Date.strptime(params[:schedule][:next], "%d/%m/%Y")) unless params[:schedule][:next].empty?
      redirect_to(recurring_slips_path, :notice => t('controllers.recurring_slips.update.success', :default => 'The reccurring slip was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def destroy
    if @recurring_slip.destroy
      flash[:notice] = t('controllers.recurring_slips.destroy.success', :default => "Recurring slip deleted")
    else
      flash[:error] = t('controllers.recurring_slips.destroy.error', :default => "Error deleting the recurring slip")
    end
    redirect_to(recurring_slips_path)
  end
end
