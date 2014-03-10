App.CustomersRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    App.Customer.find()
