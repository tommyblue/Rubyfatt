App.CustomersRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    @store.find('customer')

App.CustomerRoute = Ember.Route.extend
  model: (params) ->
    @store.find('customer', params.customer_id)