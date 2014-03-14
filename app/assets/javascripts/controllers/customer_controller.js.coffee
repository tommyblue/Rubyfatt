App.CustomerController = Ember.ObjectController.extend
  needs: ["application"]

  actions:
    editCustomer: ->
      @set('isEditing', true)

    showCustomer: ->
      @set('isEditing', false)

    saveCustomer: ->
      customer = @get('model')
      customer.save().then( (session) =>
        @get("controllers.application").notify
          title: "Success",
          message: "The customer was saved",
          type: "success",
          persists: false
        @set('isEditing', false)
      , (error) =>
        message = "Errors: "
        $.each error.errors, (key, value) ->
          message += "#{key}: #{value}, "
        @get("controllers.application").notify
          title: "The customer can't be saved",
          message: message,
          type: "alert",
          persists: false
      )

    removeCustomer: ->
      customer = @get('model')
      customer.deleteRecord()
      customer.save().then(@transitionToRoute('customers'))

    showDropdown: ->
      Foundation.libs.dropdown.toggle($('#groupDropdownLink'))

  isEditing: false
