class EstimatesController < ApplicationController
  before_filter :load_useful_data, :only => [:new, :create, :edit, :update]

  load_and_authorize_resource :customer, :through => :current_user
  load_and_authorize_resource :estimate, :through => :customer

  def index
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@estimate, view_context, I18n.t('pdf.estimate.label'))
        send_data pdf.render, filename: "estimate_#{@estimate.date.year}-#{@estimate.number.to_s.rjust(3,'0')}.pdf",
        type: "application/pdf"
      end
    end
  end

  def new
    @estimate.date = Time.now
  end

  def create
    if @estimate.save
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.estimates.create.success', :default => 'The estimate was successfully created.'))
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    @estimate = Estimate.find(params[:id])
    if @estimate.update_attributes(params[:estimate])
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.estimates.update.success', :default => 'The estimate was successfully updated.'))
    else
      render :action => "edit"
    end
  end

  def destroy
    if @estimate.destroy
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.estimates.destroy.success', :default => 'The estimate was successfully destroyed and its slips was restored'))
    else
      redirect_to(customer_slips_path(@customer), :error => t('controllers.estimates.destroy.error', :default => "Can't destroy the estimate"))
    end
  end

  private
    def load_useful_data
      @customer = current_user.customers.where(id: params[:customer_id]).first
      @slips = @customer.working_slips
      @consolidated_taxes = current_user.consolidated_taxes
    end
end
