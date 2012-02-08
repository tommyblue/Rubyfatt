class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def new
  end
  
  def create
    @invoice = Invoice.find(params[:invoice_id])
    @customer = @invoice.customer
    @invoice.paid = true
    @invoice.payment_date = Date.civil(params[:payment]["date(1i)"].to_i, params[:payment]["date(2i)"].to_i, params[:payment]["date(3i)"].to_i)
    if @invoice.save
      redirect_to(customer_slips_path(@customer), :notice => 'The invoice was successfully paid.')
    else
      flash[:warning] = "Errors during save"
      render :action => "new"
    end
  end
end
