module Calculators
  module TaxCalculator
    # Applies consolidated taxes to the slip rate
    def total
      sum = self.rate
      compounds = []
      self.consolidated_tax.taxes.each do |tax|
        # Calculate the real rate (can be fixed or percentage)
        if tax.fixed_rate
          partial = tax.rate
        else
          partial = sum * tax.rate / 100
        end

        if tax.compound
          compounds << partial
        else
          compounds.each { |compound| sum += compound }
          sum += partial
        end
      end

      compounds.each { |compound| sum += compound }
      sum
    end
  end
end
