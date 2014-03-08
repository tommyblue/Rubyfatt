CustomerPolicy = Struct.new(:user, :customer) do
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
