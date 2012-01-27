class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    
  end
  
  def new
    @customer = Customer.find(params[:customer_id])
    @invoice = @customer.invoices.new
    @invoice.date = Time.now
    @slips = @customer.working_slips
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @invoice = @customer.invoices.new(params[:invoice])
    if @invoice.save
      redirect_to(customer_slips_path(@customer), :notice => 'The invoice was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def show
    @customer = Customer.find(params[:customer_id])
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, view_context)
        send_data pdf.render, filename: "invoice_#{@invoice.date.year}-#{@invoice.number}.pdf",
        type: "application/pdf"
      end
    end
  end
end
