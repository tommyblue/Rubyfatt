FactoryGirl.define do
  # No dependencies
  factory :user do
    name "Test"
    surname "User"
    sequence(:email) {|n| "person#{n}@example.com" }
    sequence(:address) {|n| "Via di qui, #{n}"}
    zip_code "12345"
    town "Firenze"
    province "FI"
    country "Italy"
    tax_code "ABCDEF00X00A123Z"
    vat "012345678910"
    phone "+39.333.1234567"
    password "12345678"

    factory :user_with_token do
      ignore do
        tokens_count 1
      end
      after(:create) do |user, evaluator|
        create_list(:token, evaluator.tokens_count, user: user)
      end
    end
  end

  factory :token

  factory :tax do
    # consolidated_tax
    sequence(:order)
    sequence(:name) { |n| "Tax #{n}" }
    rate 4
    compound false
  end

  factory :customer do
    user
    sequence(:title) {|n| "Test Customer n. #{n}"}
    name Faker::Name.first_name
    surname Faker::Name.last_name
    address "Via Roma, 1"
    zip_code "123456"
    town "Roma"
    province "RO"
    country "Italy"
    sequence(:tax_code) {|n| "DEFABC00X00A123#{n}"}
    sequence(:vat, 1000) {|n| "01987654#{n}"}

    factory :customer_with_invoices do
      ignore do
        invoices_count 3
      end
      after(:create) do |customer, evaluator|
        create_list(:invoice, evaluator.invoices_count, customer: customer)
      end
    end
  end


  factory :consolidated_tax do
    sequence(:name) { |n| "P. IVA #{n}" }
  end


  factory :slip do
    customer
    sequence(:name) {|n| "Test Slip n. #{n}"}
    rate { rand(15000)/100.0 }
  end

  factory :invoice do
    customer
    date Time.now
    sequence(:number, 1)
    paid false
    consolidated_tax
    before(:create) do |invoice|
      invoice.slips = create_list(:slip, 2, customer: invoice.customer)
    end
  end
end
