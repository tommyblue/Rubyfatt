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
    name "Tax"
    rate 4
    compound false
  end

  factory :customer do
    user
    sequence(:title) {|n| "Test Customer n. #{n}"}
    name "Bill"
    surname "brown"
    address "Via Roma, 1"
    zip_code "123456"
    town "Roma"
    province "RO"
    country "Italy"
    sequence(:tax_code) {|n| "DEFABC00X00A123#{n}"}
    sequence(:vat, 1000) {|n| "01987654#{n}"}
  end


  factory :consolidated_tax do
    name "P. IVA"
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
      invoice.slips = FactoryGirl.create_list(:slip, 0, customer: invoice.customer)
      puts "HERE"
      puts invoice.slips.inspect
    end
  end
end
