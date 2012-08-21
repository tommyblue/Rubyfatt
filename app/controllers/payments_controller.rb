class PaymentsController < ApplicationController
  load_and_authorize_resource Invoice

  def new
    @invoice = Invoice.find(params[:invoice_id])
  end

  def create
    @invoice = Invoice.find(params[:invoice_id])
    @customer = @invoice.customer
    @invoice.paid = true
    #@invoice.payment_date = Date.civil(params[:payment]["date(1i)"].to_i, params[:payment]["date(2i)"].to_i, params[:payment]["date(3i)"].to_i)
    @invoice.payment_date = Date.strptime(params[:payment], "%d/%m/%Y")
    if @invoice.save
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.payments.create.success', :default => 'The invoice was successfully paid.'))
    else
      render :action => "new"
    end
  end
end
