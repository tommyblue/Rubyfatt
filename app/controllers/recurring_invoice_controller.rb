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
    @recurring_slip = RecurringSlip.find(params[:recurring_slip_id])
    @customer = @recurring_slip.customer
    recurring_slips_ids = []
    params[:invoice][:slip_ids].each do |recurring_slip_id|
      recurring_slips_ids << recurring_slip_id if recurring_slip_id.strip != ''
    end
    params[:invoice].delete(:slip_ids)
    @invoice = @customer.invoices.new(params[:invoice])
    recurring_slips = []
    recurring_slips_ids.each do |recurring_slip_id| # TODO: Check if they belongs to the user
      if recurring_slip = RecurringSlip.find(recurring_slip_id)
        recurring_slips << recurring_slip
        slip = Slip.new
        slip.customer = @customer
        slip.name = recurring_slip.name
        slip.rate = recurring_slip.rate
        slip.timed = false
        @invoice.slips << slip
      end
    end
    if @invoice.save
      recurring_slips.each do |recurring_slip|
        recurring_slip.goto_next_occurrence!
      end
      redirect_to(customer_slips_path(@customer), :notice => 'The invoice was successfully created.')
    else
      flash[:warning] = "Error validating the invoice"
      render :action => "new"
    end
  end
end
