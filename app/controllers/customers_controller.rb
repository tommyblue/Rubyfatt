class CustomersController < ApplicationController
  load_and_authorize_resource

  def index
    @customers = @customers.order(:title,:surname,:name)
  end

  def new
  end

  def create
    if @customer.save
      redirect_to(customers_path, :notice => t('controllers.customers.create.success', :default => 'The customer was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @customer.update_attributes(params[:customer])
      redirect_to(customers_path, :notice => t('controllers.customers.update.success', :default => 'The customer was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def destroy
    if @customer.can_be_deleted? and @customer.destroy
      flash[:success] = t('controllers.customers.destroy.success', :default => "The customer was successfully destroied")
    else
      flash[:error] = t('controllers.customers.destroy.error', :default => "Error while destroying the customer")
    end
    redirect_to(customers_path)
  end
end
