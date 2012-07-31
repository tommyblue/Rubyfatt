class ConsolidatedTaxesController < ApplicationController
  def index
    @consolidated_taxes = current_user.consolidated_taxes
  end

  def show
    @consolidated_tax = ConsolidatedTax.find(params[:id])
  end

  def new
    @consolidated_tax = current_user.ConsolidatedTax.new
  end

  def create
    @consolidated_tax = current_user.ConsolidatedTax.new(params[:tax])
    if @consolidated_tax.save
      redirect_to(@consolidated_tax, :notice => t('controllers.consolidated_taxes.create.success', :default => 'The Tax was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
    @consolidated_tax = ConsolidatedTax.find(params[:id])
  end

  def update
    @consolidated_tax = ConsolidatedTax.find(params[:id])
    if @consolidated_tax.update_attributes(params[:tax])
      redirect_to(@consolidated_tax, :notice => t('controllers.consolidated_taxes.update.success', :default => 'The Tax was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def destroy
    consolidated_tax = ConsolidatedTax.find(params[:id])
    if consolidated_tax.destroy
      flash[:success] = t('controllers.consolidated_taxes.destroy.success', :default => "The consolidated tax was successfully destroied")
    else
      flash[:error] = t('controllers.consolidated_taxes.destroy.error', :default => "Error while destroying the consolidated tax")
    end
    redirect_to(taxes_url)
  end
end
