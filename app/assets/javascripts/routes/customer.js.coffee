App.CustomersRoute = Ember.Route.extend
  model: ->
    App.Customer.find()
