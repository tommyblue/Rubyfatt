class ConsolidatedTaxesController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
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
      redirect_to(@consolidated_tax, :notice => 'The Tax was successfully created.')
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
      redirect_to(@consolidated_tax, :notice => 'The Tax was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    consolidated_tax = ConsolidatedTax.find(params[:id])
    consolidated_tax.destroy
    redirect_to(taxes_url)
  end
end
