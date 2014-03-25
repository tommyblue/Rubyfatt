App.ApplicationRoute = Ember.Route.extend Ember.SimpleAuth.ApplicationRouteMixin,
  actions:
    sessionAuthenticationSucceeded: ->
      @transitionTo 'index'
