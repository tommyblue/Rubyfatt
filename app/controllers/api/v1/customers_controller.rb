class  Api::V1::CustomersController < Api::V1::ApiController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  def index
    @customers = policy_scope(Customer).ordered
    respond_with @customers, each_serializer: CustomerSerializer
  end

  def show
    @customer = Customer.find(params[:id])
    authorize @customer, :manage?
    respond_with @customer, serializer: CustomerSerializer
  end

  def destroy
    @customer = Customer.find(params[:id])
    authorize @customer, :manage?

    if @customer.destroy
      head :no_content, status: 204
    else
      respond_with @customer.errors, status: 422
    end
  end
end
