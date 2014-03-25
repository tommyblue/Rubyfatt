class  Api::V1::InvoicesController < Api::V1::ApiController
  # after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    if params[:year]
      @invoices = policy_scope(Invoice).ordered.by_year(params[:year])
    else
      @invoices = policy_scope(Invoice).ordered
    end
    respond_with @invoices, each_serializer: InvoiceSerializer
  end
end
