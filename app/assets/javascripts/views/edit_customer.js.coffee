App.EditCustomerView = Ember.TextField.extend
  didInsertElement: ->
    this.$().focus()

Ember.Handlebars.helper('edit-customer', App.EditCustomerView)
