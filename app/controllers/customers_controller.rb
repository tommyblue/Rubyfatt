class CustomersController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    @customers = current_user.customers
  end
  
  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = current_user.customers.new
  end

  def create
    @customer = current_user.customers.new(params[:customer])
    if @customer.save
      redirect_to(@customer, :success => 'The customer was successfully created.')
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
