App.LoginController = Ember.Controller.extend Ember.SimpleAuth.LoginControllerMixin,
  needs: ["application"]
  
  reset: ->
    @setProperties
      errorMessage: null
      identification: null
      password: null
