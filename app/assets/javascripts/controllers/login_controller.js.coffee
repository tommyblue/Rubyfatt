App.LoginController = Ember.Controller.extend Ember.SimpleAuth.LoginControllerMixin,
  needs: ["application"]
  actions:
    sessionAuthenticationSucceeded: ->
      $.get '/api/v1/users/profile', data, (results) ->
        localStorage['currentUser'] = data.user
        App.set('currentUser', @store.createRecord('user', data.user))

      # @get("controllers.application").notify
      #   message: "You are now signed in",
      #   type: "success",
      #   persists: false
      @_super()

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
