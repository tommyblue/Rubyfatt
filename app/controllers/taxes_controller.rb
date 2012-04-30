class TaxesController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    @taxes = current_user.taxes
  end
  
  def show
    @tax = Tax.find(params[:id])
  end

  def new
    @tax = current_user.Tax.new
  end

  def create
    @tax = current_user.Tax.new(params[:tax])
    if @tax.save
      redirect_to(@tax, :notice => t('controllers.taxes.create.success', :default => 'The tax was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
    @tax = Tax.find(params[:id])
  end

  def update
    tax = Tax.find(params[:id])
    if tax.update_attributes(params[:tax])
      redirect_to(tax, :notice => t('controllers.taxes.update.success', :default => 'The tax was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def destroy
    tax = Tax.find(params[:id])
    if tax.destroy
      flash[:notice] = t('controllers.taxes.destroy.success', :default => "Tax deleted")
    else
      flash[:error] = t('controllers.taxes.destroy.error', :default => "Error deleting the tax")
    end
    redirect_to(taxes_url)
  end
end
