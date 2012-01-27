# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(:email => "tommaso.visconti@gmail.com", :password => "password", :name => "Tommaso", :surname => "Visconti", :address => "Via Rupe Canina 25", :zip_code => "50039", :town => "Vicchio", :province => "FI", :country => "", :tax_code => "VSCTMS83L27D612B", :vat => "05999900482", :phone => "+39.328.9478976")
user.save!

user.options.create([{:name => 'NEXT_ESTIMATE_NUMBER', :value => 1, :integer => true}, {:name => 'NEXT_INVOICE_NUMBER', :value => 1, :integer => true}])
taxes = Tax.create([{:order => 0, :name => 'INPS 4%', :rate => 4, :compound => false}, {:order => 1, :name => 'IVA 21%', :rate => 21, :compound => true}, {:order => 2, :name => "Ritenuta d'acconto -20%", :rate => -20, :compound => true}])
consolidated_tax = ConsolidatedTax.create(:name => "P. IVA")
consolidated_tax.taxes << taxes

user.taxes << taxes
user.consolidated_taxes << consolidated_tax

customer = user.customers.create(:title => "Christian Vibio", :name => "Christian", :surname => "Vibio", :address => "Via Eichenau 43", :zip_code => "50054", :town => "Budrio", :province => "BO", :country => "Italy", :tax_code => "VBICRS74M10B249A", :vat => "02703781209")

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