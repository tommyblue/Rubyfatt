user = User.create(
  :email => "demo@example.com",
  :password => "password",
  :name => "John",
  :surname => "Doe",
  :address => "Via di qui, 1",
  :zip_code => "12345",  # Il CAP
  :town => "Firenze",
  :province => "FI",
  :country => "",
  :tax_code => "ABCDEF00X00A123Z",  # Codice Fiscale
  :vat => "012345678910", # Partita IVA
  :phone => "+39.333.1234567"
)
user.save!

## Regimi di tassazione
taxes = Tax.create(
  [
    {:order => 0,
     :name => 'INPS 4%',
     :rate => 4,
     :compound => false
    },
    {
      :order => 1,
      :name => 'IVA 21%',
      :rate => 21,
      :compound => true
    },
    {
      :order => 2,
      :name => "Ritenuta d'acconto -20%",
      :rate => -20,
      :compound => true
    }
  ]
)
consolidated_tax = ConsolidatedTax.create(:name => "P. IVA")
consolidated_tax.taxes << taxes
#user.taxes << taxes
user.consolidated_taxes << consolidated_tax

## /Fine regimi di tassazione


###########################
##                       ##
##    Dati di esempio    ##
##                       ##
###########################

customer = user.customers.create(:title => "Test customer", :name => "Bill", :surname => "Brown", :address => "Via Roma, 1", :zip_code => "123456", :town => "Roma", :province => "RO", :country => "Italy", :tax_code => "DEFABC00X00A123Z", :vat => "019876543210")

slip1 = customer.slips.create(:customer_id => customer.id, :name => "Test slip 1", :rate => 14.32)
slip2 = customer.slips.create(:customer_id => customer.id, :name => "Test slip 2", :rate => 46.40)
slip3 = customer.slips.create(:customer_id => customer.id, :name => "Test slip 3", :rate => 130.00)
slip4 = customer.slips.create(:customer_id => customer.id, :name => "Test slip 4", :rate => 85.50)

estimate = customer.estimates.create(:customer_id => customer.id, :date => Time.now, :number => 1, :invoiced => false, :consolidated_tax_id => consolidated_tax.id)
slip1.estimate = estimate
slip2.estimate = estimate

invoice_project_1 = customer.invoice_projects.create(:customer_id => customer.id, :date => Time.now, :number => 1, :invoiced => true, :consolidated_tax_id => consolidated_tax.id)
invoice_project_2 = customer.invoice_projects.create(:customer_id => customer.id, :date => Time.now, :number => 2, :invoiced => false, :consolidated_tax_id => consolidated_tax.id)
slip1.invoice_project = invoice_project_1
slip2.invoice_project = invoice_project_1
slip3.invoice_project = invoice_project_2

invoice = customer.invoices.create(:customer_id => customer.id, :date => Time.now, :number => 1, :paid => false, :consolidated_tax_id => consolidated_tax.id)
slip1.invoice = invoice
slip2.invoice = invoice

slip1.save!
slip2.save!
slip3.save!
slip4.save!

recurring_slip = RecurringSlip.new(:customer_id => customer.id, :name => "Recurring slip test", :rate => 50.00)
rule = IceCube::Rule.monthly(6).day_of_month(1)
schedule = IceCube::Schedule.new
schedule.add_recurrence_rule rule
recurring_slip.schedule = schedule
recurring_slip.start_date = Date.strptime(Time.now.yesterday.strftime("%d/%m/%Y"), "%d/%m/%Y")
recurring_slip.save!
