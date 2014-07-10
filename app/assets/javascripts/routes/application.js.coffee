App.ApplicationRoute = Ember.Route.extend Ember.SimpleAuth.ApplicationRouteMixin,
  # beforeModel: (transition) ->
  #   @_super(transition)
  #   if !@get(Configuration.sessionPropertyName).get('isAuthenticated')
  #     transition.abort()
  #     @get(Configuration.sessionPropertyName).set('attemptedTransition', transition)
  #     transition.send('authenticateSession')

  redirect: ->
    @transitionTo 'index'
