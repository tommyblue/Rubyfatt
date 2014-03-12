App.CustomerController = Ember.ObjectController.extend
  actions:
    editCustomer: ->
      @set('isEditing', true)
    acceptChanges: ->
      @set('isEditing', false)
      @get('model').save()
    removeCustomer: ->
      customer = @get('model')
      customer.deleteRecord()
      customer.save()
  isEditing: false,
