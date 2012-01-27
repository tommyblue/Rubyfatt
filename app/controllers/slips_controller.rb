class SlipsController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    @customer = Customer.find(params[:customer_id])
    @slips = @customer.working_slips
    @estimates = @customer.estimates
    @invoices = @customer.invoices
  end
  
  def new
    @customer = Customer.find(params[:customer_id])
    @slip = @customer.slips.new
  end

  def show
    @customer = Customer.find(params[:customer_id])
    @slip = Slip.find(params[:id])
  end
  
  def create
    @customer = Customer.find(params[:customer_id])
    @slip = @customer.slips.new(params[:slip])
    if @slip.save
      redirect_to(customer_slip_path(@customer, @slip), :notice => 'The slip was successfully created.')
    else
      render :action => "new"
    end
  end
end
