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
    @recurring_slip.start_date = DateTime.civil(params[:schedule]["next(1i)"].to_i, params[:schedule]["next(2i)"].to_i, params[:schedule]["next(3i)"].to_i)
    if @recurring_slip.save
      redirect_to(recurring_slips_path, :success => 'The recurring slip was successfully created.')
    else
      render :action => "new"
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      redirect_to(@customer, :success => 'The Customer was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to(customers_url)
  end
end
