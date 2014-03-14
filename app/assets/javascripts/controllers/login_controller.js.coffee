App.LoginController = Ember.Controller.extend Ember.SimpleAuth.LoginControllerMixin,
  needs: ["application"]
  actions:
    sessionAuthenticationSucceeded: ->
      @get("controllers.application").notify
        message: "You are now signed in",
        type: "success",
        persists: false
      @transitionTo 'index'
    sessionAuthenticationFailed: (error) ->
      msg = JSON.parse(error).error
      @get("controllers.application").notify
        message: msg,
        type: "alert",
        persists: false

  reset: ->
    @setProperties
      errorMessage: null
      identification: null
      password: null
