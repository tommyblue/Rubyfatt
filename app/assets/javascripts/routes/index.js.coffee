App.IndexRoute = Ember.Route.extend Ember.SimpleAuth.AuthenticatedRouteMixin,
  redirect: ->
    @transitionTo('customers')
