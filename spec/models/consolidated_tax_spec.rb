require 'spec_helper'

describe ConsolidatedTax do
  it "should have taxes correctly sorted by default" do
    generate_scenario
    ordered_taxes = @consolidated_tax.taxes
    ordered_taxes[0].id.should eq @tax1.id
    ordered_taxes[1].id.should eq @tax2.id
    ordered_taxes[2].id.should eq @tax3.id

    # Let's shuffle them and check again
    @tax2.update_attribute :order, 5
    @tax1.update_attribute :order, 7

    @consolidated_tax.reload
    ordered_taxes = @consolidated_tax.taxes

    ordered_taxes[0].id.should eq @tax3.id
    ordered_taxes[1].id.should eq @tax2.id
    ordered_taxes[2].id.should eq @tax1.id

  end
end
