class  Api::V1::CustomersController < Api::V1::ApiController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @customers = policy_scope(Customer).ordered
    respond_with @customers, each_serializer: CustomerSerializer
  end

  def show
    @customer = @user.customers.find(params[:id])
    authorize @customer, :manage?
    respond_with @customer, serializer: CustomerSerializer
  end

  def create
    @customer = @user.customers.new(customer_params)
    authorize @customer, :manage?
    if @customer.save
      respond_with @customer, { location: nil, serializer: CustomerSerializer }
    else
      respond_with @customer, { location: nil, status: 422 }
    end
  end

  def update
    @customer = @user.customers.find(params[:id])
    authorize @customer, :manage?
    if @customer.update_attributes(customer_params)
      respond_with @customer, { location: nil, serializer: CustomerSerializer }
    else
      respond_with @customer, { location: nil, status: 422 }
    end
  end

  def destroy
    @customer = @user.customers.find(params[:id])
    authorize @customer, :manage?

    if @customer.destroy
      head :no_content, status: 204
    else
      render nothing: true, status: 422
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:title, :name, :surname, :address, :zip_code, :town, :province, :country, :tax_code, :vat, :info)
  end
end
