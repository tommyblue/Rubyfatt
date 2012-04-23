class CreateInvoiceProjects < ActiveRecord::Migration
  def change
    create_table :invoice_projects do |t|
      t.references :customer
      t.references :consolidated_tax
      t.date :date, :null => false
      t.integer :number, :null => false
      t.boolean :invoiced, :default => false
      t.timestamps
    end
    
    say "Adding NEXT_INVOICE_PROJECT_NUMBER option to users"
    User.all.each do |user|
      unless user.options.find_by_name("NEXT_INVOICE_PROJECT_NUMBER")
        user.options.create([{:name => 'NEXT_INVOICE_PROJECT_NUMBER', :value => 1, :integer => true}])
      end
    end
  end
end
