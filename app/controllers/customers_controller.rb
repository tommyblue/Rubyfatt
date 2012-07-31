class CustomersController < ApplicationController
  def index
    @customers = current_user.customers.order(:title,:surname,:name)
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
      redirect_to(customers_path, :notice => t('controllers.customers.create.success', :default => 'The customer was successfully created.'))
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
      redirect_to(customers_path, :notice => t('controllers.customers.update.success', :default => 'The customer was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    if customer.can_be_deleted? and customer.destroy
      flash[:success] = t('controllers.customers.destroy.success', :default => "The customer was successfully destroied")
    else
      flash[:error] = t('controllers.customers.destroy.error', :default => "Error while destroying the customer")
    end
    redirect_to(customers_url)
  end
end
