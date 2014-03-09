# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->
  @resource('customers')

App.ProtectedRoute = Ember.Route.extend(Ember.SimpleAuth.AuthenticatedRouteMixin)
