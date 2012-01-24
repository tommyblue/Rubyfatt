# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(:email => "tommaso.visconti@gmail.com", :password => "password", :name => "Tommaso", :surname => "Visconti", :address => "Via Rupe Canina 25", :zip_code => "50039", :town => "Vicchio", :province => "FI", :country => "", :tax_code => "VSCTMS83L27D612B", :vat => "05999900482")

taxes = Tax.create([{:order => 0, :name => 'INPS 4%', :rate => 4, :compound => false}, {:order => 1, :name => 'IVA 21%', :rate => 21, :compound => true}, {:order => 2, :name => "Ritenuta d'acconto -20%", :rate => -20, :compound => true}])
consolidated_tax = ConsolidatedTax.create(:name => "P. IVA")
consolidated_tax.taxes << taxes

user.taxes << taxes
user.consolidated_taxes << consolidated_tax

customer = user.customers.create(:title => "Christian Vibio", :name => "Christian", :surname => "Vibio", :address => "Via Eichenau 43", :zip_code => "50054", :town => "Budrio", :province => "BO", :country => "Italy", :tax_code => "VBICRS74M10B249A", :vat => "02703781209")