class TaxesController < ApplicationController
  load_and_authorize_resource :consolidated_tax
  load_and_authorize_resource :tax, :through => :consolidated_tax

  def new
    @tax.order = @consolidated_tax.suggest_order
  end

  def create
    @tax = @consolidated_tax.taxes.new(params[:tax])
    if @tax.save
      redirect_to(consolidated_taxes_path, :notice => t('controllers.taxes.create.success', :default => 'The tax was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @tax.update_attributes(params[:tax])
      redirect_to(consolidated_taxes_path, :notice => t('controllers.taxes.update.success', :default => 'The tax was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def destroy
    if @tax.destroy
      flash[:notice] = t('controllers.taxes.destroy.success', :default => "Tax deleted")
    else
      flash[:error] = t('controllers.taxes.destroy.error', :default => "Error deleting the tax")
    end
    redirect_to :back
  end
end
