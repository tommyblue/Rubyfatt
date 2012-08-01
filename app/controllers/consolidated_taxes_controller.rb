class ConsolidatedTaxesController < ApplicationController
  def index
    @consolidated_taxes = current_user.consolidated_taxes
  end

  def new
    @consolidated_tax = current_user.consolidated_taxes.new
  end

  def create
    @consolidated_tax = current_user.consolidated_taxes.new(params[:consolidated_tax])
    if @consolidated_tax.save
      redirect_to(consolidated_taxes_path, :notice => t('controllers.consolidated_taxes.create.success', :default => 'The consolidated tax was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
    @consolidated_tax = current_user.consolidated_taxes.where(id: params[:id]).first
  end

  def update
    @consolidated_tax = current_user.consolidated_taxes.where(id: params[:id]).first
    if @consolidated_tax.update_attributes(params[:consolidated_tax])
      redirect_to(consolidated_taxes_path, :notice => t('controllers.consolidated_taxes.update.success', :default => 'The Tax was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def destroy
    @consolidated_tax = current_user.consolidated_taxes.where(id: params[:id]).first
    if @consolidated_tax.can_be_deleted? and @consolidated_tax.destroy
      flash[:success] = t('controllers.consolidated_taxes.destroy.success', :default => "The consolidated tax was successfully destroied")
    else
      flash[:error] = t('controllers.consolidated_taxes.destroy.error', :default => "Error while destroying the consolidated tax, maybe some data exists with this consolidated tax")
    end
    redirect_to(consolidated_taxes_path)
  end
end
