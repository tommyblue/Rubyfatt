describe CustomerSerializer do
  it "creates JSON version for the API" do
    generate_scenario
    serializer = CustomerSerializer.new @customer1

    json = {
      customer: {
        id: @customer1.id,
        user_id: @customer1.user_id,
        title: @customer1.title,
        name: @customer1.name,
        surname: @customer1.surname,
        address: @customer1.address,
        zip_code: @customer1.zip_code,
        town: @customer1.town,
        province: @customer1.province,
        country: @customer1.country,
        tax_code: @customer1.tax_code,
        vat: @customer1.vat,
        info: @customer1.info,
        created_at: @customer1.created_at,
        updated_at: @customer1.updated_at
      }
    }.to_json

    expect(serializer.to_json).to eql(json.to_s)
  end
end
