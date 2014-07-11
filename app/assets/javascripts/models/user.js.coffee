App.User = DS.Model.extend
  email: DS.attr('string')
  title: DS.attr('string')
  name: DS.attr('string')
  surname: DS.attr('string')
  address: DS.attr('string')
  zip_code: DS.attr('string')
  town: DS.attr('string')
  province: DS.attr('string')
  country: DS.attr('string')
  tax_code: DS.attr('string')
  vat: DS.attr('string')
  phone: DS.attr('string')
  language: DS.attr('string')
  created_at: DS.attr('date')
  updated_at: DS.attr('date')
  full_name: (->
    @.get('name') + ' ' + @.get('surname')
  ).property('name', 'surname')
  full_address: (->
    addr = ''
    addr += @.get('address') if @.get('address')
    addr += ', ' + @.get('zip_code') if @.get('zip_code')
    addr += ', ' + @.get('town') if @.get('town')
    addr += ' (' + @.get('province') + ')' if @.get('province')
    addr += ', ' + @.get('country') if @.get('country')
    return addr
  ).property('address', 'zip_code', 'town', 'province', 'country')

