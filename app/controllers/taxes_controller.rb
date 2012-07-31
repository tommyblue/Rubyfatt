class TaxesController < ApplicationController
  def new
    @consolidated_tax = ConsolidatedTax.find(params[:consolidated_tax_id])
    @tax = @consolidated_tax.taxes.new
  end

  def create
    @consolidated_tax = ConsolidatedTax.find(params[:consolidated_tax_id])
    @tax = @consolidated_tax.taxes.new(params[:tax])
    if @tax.save
      redirect_to(consolidated_taxes_path, :notice => t('controllers.taxes.create.success', :default => 'The tax was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
    @consolidated_tax = ConsolidatedTax.find(params[:consolidated_tax_id])
    @tax = @consolidated_tax.taxes.where(id: params[:id]).first
  end

  def update
    @consolidated_tax = ConsolidatedTax.find(params[:consolidated_tax_id])
    @tax = @consolidated_tax.taxes.where(id: params[:id]).first
    if @tax.update_attributes(params[:tax])
      redirect_to(consolidated_taxes_path, :notice => t('controllers.taxes.update.success', :default => 'The tax was successfully updated.'))
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
    redirect_to :back
  end
end
