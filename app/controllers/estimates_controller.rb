class EstimatesController < ApplicationController
  before_filter :authenticate_user!
  layout "main"

  def index

  end

  def new
    @customer = Customer.find(params[:customer_id])
    @estimate = @customer.estimates.build
    @estimate.date = Time.now
    @slips = @customer.working_slips
    @consolidated_taxes = current_user.consolidated_taxes
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @estimate = @customer.estimates.new(params[:estimate])
    @slips = @customer.working_slips
    @consolidated_taxes = current_user.consolidated_taxes
    if @estimate.save
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.estimates.create.success', :default => 'The estimate was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
    @estimate = Estimate.find(params[:id])
    @customer = @estimate.customer
    @slips = @customer.working_slips
  end

  def update
    @estimate = Estimate.find(params[:id])
    @customer = @estimate.customer
    if @estimate.update_attributes(params[:estimate])
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.estimates.update.success', :default => 'The estimate was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def show
    @customer = Customer.find(params[:customer_id])
    @estimate = Estimate.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@estimate, view_context, I18n.t('pdf.estimate.label'))
        send_data pdf.render, filename: "estimate_#{@estimate.date.year}-#{@estimate.number.to_s.rjust(3,'0')}.pdf",
        type: "application/pdf"
      end
    end
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    @estimate = Estimate.find(params[:id])
    if @estimate.destroy
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.estimates.destroy.success', :default => 'The estimate was successfully destroyed and its slips was restored'))
    else
      redirect_to(customer_slips_path(@customer), :error => t('controllers.estimates.destroy.error', :default => "Can't destroy the estimate"))
    end
  end
end
