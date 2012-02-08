class RecurringInvoiceController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def new
    @recurring_slip = RecurringSlip.find(params[:recurring_slip_id])
    @customer = @recurring_slip.customer
    @invoice = @customer.invoices.new
    @invoice.date = Time.now
    @consolidated_taxes = current_user.consolidated_taxes
  end

  def create
    raise 's'
    @recurring_slip = RecurringSlip.find(params[:recurring_slip_id])
    @customer = @recurring_slip.customer
    @customer = Customer.find(params[:customer_id])
    @invoice = @customer.invoices.new(params[:invoice])
    if @invoice.save
      redirect_to(customer_slips_path(@customer), :notice => 'The invoice was successfully created.')
    else
      flash[:warning] = "Error validating the invoice"
      render :action => "new"
    end
  end
end
