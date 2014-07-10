class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :language, :title, :name, :surname, :address, :zip_code, :town, :province, :country, :tax_code, :vat, :created_at, :updated_at
end

