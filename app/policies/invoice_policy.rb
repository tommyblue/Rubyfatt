InvoicePolicy = Struct.new(:user, :invoice) do
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      scope.joins(:customer).where(customers: { user_id: user.id } )
    end
  end

  def manage?
    invoice.customer.user == user
  end
end

