class InvoiceProjectsController < ApplicationController
  before_filter :authenticate_user!
  layout "main"
  
  def index
    @invoice_projects = current_user.invoice_projects
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
    bank_coordinates = current_user.options.find_by_name('BANK_COORDINATES')
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice_project, view_context, I18n.t('pdf.invoice.label'), bank_coordinates.nil? ? nil : bank_coordinates.value)
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
  def to_invoice
    @invoice_project = InvoiceProject.find(params[:id])
    if @invoice_project.to_invoice
      redirect_to(customer_slips_path(@invoice_project.customer), :notice => t('controllers.invoice_projects.to_invoice.success', :default => 'The invoice project was successfully tranformed to invoice'))
    else
      redirect_to(customer_slips_path(@invoice_project.customer), :error => t('controllers.invoice_projects.to_invoice.error', :default => "Error during the operation."))
    end
  end
end
