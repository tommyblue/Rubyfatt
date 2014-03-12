App.CustomerController = Ember.ObjectController.extend
  actions:
    editCustomer: ->
      @set('isEditing', true)
    showCustomer: ->
      @set('isEditing', false)
    saveCustomer: ->
      @set('isEditing', false)
      customer = @get('model')
      customer.save()
    removeCustomer: ->
      customer = @get('model')
      customer.deleteRecord()
      customer.save().then(@transitionToRoute('customers'))
  isEditing: false,
