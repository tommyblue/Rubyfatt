App.LoginController = Ember.Controller.extend(Ember.SimpleAuth.LoginControllerMixin, {
  needs: ["application"],

  reset: function() {
    this.setProperties({
      errorMessage: null,
      identification: null,
      password: null
    })
  }
});
