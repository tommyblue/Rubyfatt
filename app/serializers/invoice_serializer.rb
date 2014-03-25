class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :customer_id, :consolidated_tax_id, :invoice_project_id, :date, :number, :payment_date, :downloaded, :created_at, :updated_at
end
