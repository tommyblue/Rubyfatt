class Api::V1::CustomersController < Api::V1::ApiController
  def index
    @customers = Customer.all
    respond_with @customers, each_serializer: CustomerSerializer
  end
end
