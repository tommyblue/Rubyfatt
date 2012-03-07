user = User.create(:email => "demo@example.com", :password => "password", :name => "John", :surname => "Doe", :address => "Via di qui, 1", :zip_code => "12345", :town => "Firenze", :province => "FI", :country => "", :tax_code => "ABCDEF00X00A123Z", :vat => "012345678910", :phone => "+39.333.1234567")
user.save!

user.options.create([{:name => 'NEXT_ESTIMATE_NUMBER', :value => 1, :integer => true}, {:name => 'NEXT_INVOICE_NUMBER', :value => 1, :integer => true}])
taxes = Tax.create([{:order => 0, :name => 'INPS 4%', :rate => 4, :compound => false}, {:order => 1, :name => 'IVA 21%', :rate => 21, :compound => true}, {:order => 2, :name => "Ritenuta d'acconto -20%", :rate => -20, :compound => true}])
consolidated_tax = ConsolidatedTax.create(:name => "P. IVA")
consolidated_tax.taxes << taxes

user.taxes << taxes
user.consolidated_taxes << consolidated_tax

customer = user.customers.create(:title => "Test customer", :name => "Bill", :surname => "Brown", :address => "Via Roma, 1", :zip_code => "123456", :town => "Roma", :province => "RO", :country => "Italy", :tax_code => "DEFABC00X00A123Z", :vat => "019876543210")

slip1 = customer.slips.create(:customer_id => customer.id, :name => "Test slip 1", :rate => 14.32)
slip2 = customer.slips.create(:customer_id => customer.id, :name => "Test slip 2", :rate => 46.40)

estimate = customer.estimates.create(:customer_id => customer.id, :date => Time.now, :number => 1, :invoiced => false, :consolidated_tax_id => consolidated_tax.id)
slip1.estimate = estimate
slip2.estimate = estimate

invoice = customer.invoices.create(:customer_id => customer.id, :date => Time.now, :number => 1, :paid => false, :consolidated_tax_id => consolidated_tax.id)
slip1.invoice = invoice
slip2.invoice = invoice

slip1.save!
slip2.save!