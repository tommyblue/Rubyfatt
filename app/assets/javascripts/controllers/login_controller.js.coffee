App.LoginController = Ember.Controller.extend Ember.SimpleAuth.LoginControllerMixin,
  actions:
    sessionAuthenticationFailed: (error) ->
      msg = JSON.parse(error).error
      @set('errorMessage', msg)
    closeMessage: ->
      @set('errorMessage', null)

  reset: ->
    @setProperties
      errorMessage: null
      identification: null
      password: null
