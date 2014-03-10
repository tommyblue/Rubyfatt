class  Api::V1::CustomersController < Api::V1::ApiController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  def index
    @customers = policy_scope(Customer).ordered
    respond_with @customers, each_serializer: CustomerSerializer
  end

  def show
    @customer = Customer.find(params[:id])
    authorize @customer, :show?
    respond_with @customer, serializer: CustomerSerializer
  end
end
