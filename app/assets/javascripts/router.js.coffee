App.Router.map ()->
  @route 'login'
  @resource 'customers', ->
    @route 'new'
  @resource 'customer', { path: '/customer/:customer_id' }

Ember.Route.reopen
  # close any open notifcations before a route loads
  activate: ->
    @controllerFor('application').closeNotification()
    @_super()
