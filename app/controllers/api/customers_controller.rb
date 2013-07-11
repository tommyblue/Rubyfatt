module Api
  class CustomersController < ApiController
    respond_to :json
    load_and_authorize_resource

    def update
      if @customer.update_attributes(params[:customer])
        respond_with @customer, { location: nil, status: 200 }
      else
        respond_with({error: "error"}, {location: nil, status: 403 })
      end
    end
  end
end
