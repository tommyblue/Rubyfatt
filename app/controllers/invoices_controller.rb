class InvoicesController < ApplicationController
  def index

  end

  def new
    @customer = Customer.find(params[:customer_id])
    @invoice = @customer.invoices.new
    @invoice.date = Time.now
    @slips = @customer.working_slips
    @consolidated_taxes = current_user.consolidated_taxes
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @invoice = @customer.invoices.new(params[:invoice])
    @slips = @customer.working_slips
    @consolidated_taxes = current_user.consolidated_taxes
    if @invoice.save
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.invoices.create.success', :default => 'The invoice was successfully created.'))
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
        send_data pdf.render, filename: "invoice_#{@invoice.date.year}-#{@invoice.number.to_s.rjust(3,'0')}.pdf",
        type: "application/pdf"
      end
    end
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    @invoice = Invoice.find(params[:id])
    if @invoice.restore_and_destroy
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.invoices.create.success', :default => 'The invoice was successfully destroyed and its slips was restored'))
    else
      redirect_to(customer_slips_path(@customer), :error => t('controllers.invoices.create.success', :default => "Can't destroy a paid invoice"))
    end
  end

  # Shows all user's invoices
  def all
    @selected_year = params[:year] ? params[:year] : Time.now.year
    @invoices = current_user.invoices.by_year(@selected_year)
  end
end
