class PaymentsController < ApplicationController

  def new
    @invoice = Invoice.find(params[:invoice_id])
    authorize! :read, @invoice
  end

  def create
    @invoice = Invoice.find(params[:invoice_id])
    authorize! :update, @invoice
    @customer = @invoice.customer
    begin
      if @invoice.pay(Date.strptime(params[:payment], "%d/%m/%Y"))
        redirect_to(customer_slips_path(@customer), notice: t('controllers.payments.create.success', default: 'The invoice was successfully paid.'))
      else
        render action: "new"
      end
    rescue
      flash[:error] = t('controllers.payments.create.unexpected_error', default: "Unexpected error. It wasn't possible to save the invoice payment")
      render action: "new"
    end
  end
end
