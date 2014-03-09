class  Api::V1::CustomersController < Api::V1::ApiController
  # after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  def index
    @customers = policy_scope(Customer)
    respond_with @customers, each_serializer: CustomerSerializer
  end
end
