module BaseInvoice
  module ClassMethods
  end

  module InstanceMethods
  end

  def self.included( base )
    base.send :extend, BaseInvoice::ClassMethods
    base.send :include, BaseInvoice::InstanceMethods
    base.send :include, ::Calculators::TaxCalculator

    base.send :default_scope, Proc.new { base.order DbAdapter.get_year("#{base.table_name}.date"), "#{base.table_name}.number", "#{base.table_name}.id" }
    base.send :scope, :sorted, -> { base.order('date DESC') }
    base.send :scope, :by_year, lambda { |year| base.where("date >= ? and date <= ?", "#{year}-01-01", "#{year}-12-31") }

    base.before_create do |base_invoice|
      option = Option.get_option(base_invoice.customer.user, base_invoice.class.next_option_name)
      base_invoice.number = option.value.to_i
    end

    base.after_create do |base_invoice|
      option = Option.get_option(base_invoice.customer.user, base_invoice.class.next_option_name)
      option.value = option.value.to_i + 1
      option.save!
    end
  end
end
