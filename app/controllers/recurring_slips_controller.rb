class RecurringSlipsController < ApplicationController
  def index
    @recurring_slips = current_user.recurring_slips.order('next_occurrence ASC').all
  end

  def show
    @recurring_slip = RecurringSlip.find(params[:id])
  end

  def new
    @recurring_slip = current_user.recurring_slips.new
  end

  def create
    @recurring_slip = current_user.recurring_slips.new(params[:recurring_slip])
    rule = IceCube::Rule.monthly(params[:schedule][:month].to_i).day_of_month(params[:schedule][:day].to_i)
    schedule = IceCube::Schedule.new
    schedule.add_recurrence_rule rule
    @recurring_slip.schedule = schedule
    @recurring_slip.start_date = Date.strptime(params[:schedule][:next], "%d/%m/%Y") unless params[:schedule][:next].empty?
    if @recurring_slip.save
      redirect_to(recurring_slips_path, :notice => t('controllers.recurring_slips.create.success', :default => 'The recurring slip was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
    @recurring_slip = RecurringSlip.find(params[:id])
  end

  def update
    @recurring_slip = RecurringSlip.find(params[:id])
    if @recurring_slip.update_attributes(params[:recurring_slip])
      redirect_to(recurring_slips_path, :notice => t('controllers.recurring_slips.update.success', :default => 'The reccurring slip was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def destroy
    recurring_slip = RecurringSlip.find(params[:id])
    if recurring_slip.destroy
      flash[:notice] = t('controllers.recurring_slips.destroy.success', :default => "Recurring slip deleted")
    else
      flash[:error] = t('controllers.recurring_slips.destroy.error', :default => "Error deleting the recurring slip")
    end
    redirect_to(recurring_slips_url)
  end
end
