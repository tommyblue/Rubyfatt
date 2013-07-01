class SlipsController < ApplicationController
  load_and_authorize_resource :customer, except: :working
  load_and_authorize_resource :slip, through: :customer, parent: false, except: :working
  load_and_authorize_resource :estimate, through: :customer, parent: false, only: :index
  load_and_authorize_resource :invoice, through: :customer, parent: false, only: :index
  load_and_authorize_resource :invoice_project, through: :customer, parent: false, only: :index

  def index
    @slips = @customer.working_slips
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @slip = @customer.slips.new
  end

  def create
    if @slip.save
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.slips.create.success', :default => 'The slip was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @slip.update_attributes(params[:slip])
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.slips.update.success', :default => 'The slip was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def working
    @slips = current_user.slips.working
    authorize! :manage, Slip
  end

  def destroy
    if @slip.destroy
      flash[:notice] = t('controllers.slips.destroy.success', :default => "Slip deleted")
    else
      flash[:error] = t('controllers.slips.destroy.error', :default => "Error deleting the slip")
    end
    redirect_to(customer_slips_path(@customer))
  end
end
