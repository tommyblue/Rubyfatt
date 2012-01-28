class SlipsController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    @customer = Customer.find(params[:customer_id])
    @slips = @customer.working_slips
    @estimates = @customer.estimates
    @invoices = @customer.invoices
  end
  
  def show
    @customer = Customer.find(params[:customer_id])
    @slip = Slip.find(params[:id])
  end
  
  def new
    @customer = Customer.find(params[:customer_id])
    @slip = @customer.slips.new
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @slip = @customer.slips.new(params[:slip])
    if @slip.save
      redirect_to(customer_slips_path(@customer), :success => 'The slip was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def edit
    @slip = Slip.find(params[:id])
    @customer = @slip.customer
  end

  def update
    @slip = Slip.find(params[:id])
    @customer = @slip.customer
    if @slip.update_attributes(params[:slip])
      redirect_to(customer_slips_path(@customer), :success => 'The slip was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
