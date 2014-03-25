App.CustomersIndexRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    @store.find('customer')

App.CustomerRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: (params) ->
    @store.find('customer', params.customer_id)

App.CustomersNewRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  model: ->
    # @store.createRecord('post')
    App.Customer.createRecord({})
