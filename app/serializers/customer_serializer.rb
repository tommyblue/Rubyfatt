class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :title, :name, :surname, :address, :zip_code, :town, :province, :country, :tax_code, :vat, :info, :created_at, :updated_at
end
