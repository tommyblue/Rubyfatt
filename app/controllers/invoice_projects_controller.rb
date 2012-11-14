class InvoiceProjectsController < ApplicationController
  load_and_authorize_resource :customer
  load_and_authorize_resource :invoice_project, :through => :customer, :except => [:index, :to_invoice_form, :to_invoice, :from_recurring_slip, :create_from_recurring_slip]

  def index
    @invoiced_invoice_projects = current_user.invoice_projects.invoiced
    @uninvoiced_invoice_projects = current_user.invoice_projects.uninvoiced
    authorize! :read, Invoice
  end

  def new
    @invoice_project.date = Time.now
    @slips = @customer.working_slips
    @consolidated_taxes = current_user.consolidated_taxes
  end

  def create
    @slips = @customer.working_slips
    @consolidated_taxes = current_user.consolidated_taxes
    if @invoice_project.save
      redirect_to(customer_slips_path(@customer), :notice => t('controllers.invoice_projects.create.success', :default => 'The invoice project was successfully created.'))
    else
      render :action => "new"
    end
  end

  def show
    bank_coordinates = current_user.bank_coordinates
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice_project, view_context, I18n.t('pdf.invoice_project.label'), (bank_coordinates.nil? || bank_coordinates.strip == '' ) ? nil : bank_coordinates)
        @invoice_project.update_download_status
        send_data pdf.render, filename: "invoice_project_#{@invoice_project.date.year}-#{@invoice_project.number.to_s.rjust(3,'0')}.pdf",
        type: "application/pdf"
      end
    end
  end

  def destroy
    if @invoice_project.restore_slips_and_destroy
      redirect_to(:back, :notice => t('controllers.invoice_projects.destroy.success', :default => 'The invoice project was successfully destroyed'))
    else
      redirect_to(:back, :error => t('controllers.invoice_projects.destroy.error', :default => "Error during the operation."))
    end
  end

  # Creates invoice from invoice project
  def to_invoice_form
    @invoice_project = InvoiceProject.find(params[:invoice_project_id])
    @customer = @invoice_project.customer
    @invoice = Invoice.new
    @invoice.date = Time.now
    authorize! :new, @invoice_project
  end

  def to_invoice
    @invoice_project = InvoiceProject.find(params[:invoice_project_id])
    authorize! :create, @invoice_project
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
    @slips = @customer.slips.working
    authorize! :new, @invoice_project
  end

  def create_from_recurring_slip
    @recurring_slip = RecurringSlip.find(params[:id])
    @customer = @recurring_slip.customer

    @invoice_project = @customer.invoice_projects.new(params[:invoice_project])

    slip = Slip.new
    slip.customer = @customer
    slip.name = @recurring_slip.name
    slip.rate = @recurring_slip.rate
    slip.timed = false
    @invoice_project.slips << slip

    authorize! :create, @invoice_project

    if @invoice_project.save
      @recurring_slip.goto_next_occurrence!

      redirect_to(customer_slips_path(@customer), :notice => t('controllers.recurring_invoice_project.create.success', :default => 'The invoice project was successfully created.'))
    else
      render :action => "from_recurring_slip"
    end
  end
end
