class InvoiceProjectsController < ApplicationController
  def index
    @invoiced_invoice_projects = current_user.invoice_projects.invoiced
    @uninvoiced_invoice_projects = current_user.invoice_projects.uninvoiced
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @invoice_project = @customer.invoice_projects.new
    @invoice_project.date = Time.now
    @slips = @customer.working_slips
    @consolidated_taxes = current_user.consolidated_taxes
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @invoice_project = @customer.invoice_projects.new(params[:invoice_project])
    @slips = @customer.working_slips
    @consolidated_taxes = current_user.consolidated_taxes
    if @invoice_project.save
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.invoice_projects.create.success', :default => 'The invoice project was successfully created.'))
    else
      render :action => "new"
    end
  end

  def show
    @customer = Customer.find(params[:customer_id])
    @invoice_project = InvoiceProject.find(params[:id])
    bank_coordinates = current_user.bank_coordinates
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice_project, view_context, I18n.t('pdf.invoice_project.label'), (bank_coordinates.nil? || bank_coordinates.strip == '' ) ? nil : bank_coordinates)
        send_data pdf.render, filename: "invoice_project_#{@invoice_project.date.year}-#{@invoice_project.number.to_s.rjust(3,'0')}.pdf",
        type: "application/pdf"
      end
    end
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    @invoice_project = InvoiceProject.find(params[:id])
    if @invoice_project.restore_slips_and_destroy
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.invoice_projects.destroy.success', :default => 'The invoice project was successfully destroyed'))
    else
      redirect_to(customer_slips_path(@customer), :error => t('controllers.invoice_projects.destroy.error', :default => "Error during the operation."))
    end
  end

  # Creates invoice from invoice project
  def to_invoice_form
    @invoice_project = InvoiceProject.find(params[:invoice_project_id])
    @customer = @invoice_project.customer
    @invoice = Invoice.new
    @invoice.date = @invoice_project.date
  end

  def to_invoice
    @invoice_project = InvoiceProject.find(params[:invoice_project_id])
    if @invoice_project.to_invoice(params[:invoice])
      redirect_to(customer_slips_path(@invoice_project.customer), :notice => t('controllers.invoice_projects.to_invoice.success', :default => 'The invoice project was successfully tranformed to invoice'))
    else
      flash.now[:error] = t('controllers.invoice_projects.to_invoice.error', :default => "Error during the operation.")
      render :to_invoice_form
    end
  end

  # Creates an invoice project from an expired recurring slip
  def from_recurring_slip
    @recurring_slip = RecurringSlip.find(params[:id])
    @customer = @recurring_slip.customer
    @invoice_project = @customer.invoice_projects.new
    @invoice_project.date = Time.now
    @consolidated_taxes = current_user.consolidated_taxes
  end

  def create_from_recurring_slip
    @recurring_slip = RecurringSlip.find(params[:id])
    @customer = @recurring_slip.customer
    recurring_slips_ids = []
    params[:invoice_project][:slip_ids].each do |recurring_slip_id|
      recurring_slips_ids << recurring_slip_id if recurring_slip_id.strip != ''
    end
    params[:invoice_project].delete(:slip_ids)
    @invoice_project = @customer.invoice_projects.new(params[:invoice_project])
    recurring_slips = []
    recurring_slips_ids.each do |recurring_slip_id| # TODO: Check if they belongs to the user
      if recurring_slip = RecurringSlip.find(recurring_slip_id)
        recurring_slips << recurring_slip
        slip = Slip.new
        slip.customer = @customer
        slip.name = recurring_slip.name
        slip.rate = recurring_slip.rate
        slip.timed = false
        @invoice_project.slips << slip
      end
    end
    if @invoice_project.save
      recurring_slips.each do |recurring_slip|
        recurring_slip.goto_next_occurrence!
      end
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.recurring_invoice_project.create.success', :default => 'The invoice project was successfully created.'))
    else
      render :action => "from_recurring_slip"
    end
  end
end
