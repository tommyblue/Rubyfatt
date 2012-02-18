class RecurringSlipsController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    @recurring_slips = current_user.recurring_slips.all
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
    @recurring_slip.start_date = Date.strptime(params[:schedule][:next], "%d/%m/%Y")
    if @recurring_slip.save
      redirect_to(recurring_slips_path, :notice => 'The recurring slip was successfully created.')
    else
      render :action => "new"
    end
  end

  def destroy
    @recurring_slip = RecurringSlip.find(params[:id])
    if @recurring_slip.destroy
      flash[:notice] = "Recurring slip deleted"
    else
      flash[:error] = "Error deleting the recurring slip"
    end
    redirect_to(recurring_slips_url)
  end
end
