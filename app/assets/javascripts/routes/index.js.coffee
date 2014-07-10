App.IndexRoute = Ember.Route.extend
  redirect: ->
    sessionAuthenticationSucceeded: ->
      @transitionTo('customers')
    sessionAuthenticationFailed: (error) ->
      console.log 'ko'
      @send 'authorizationFailed'
