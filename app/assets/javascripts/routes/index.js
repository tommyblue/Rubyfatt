App.IndexRoute = Ember.Route.extend({
  redirect: function() {
  },
  sessionAuthenticationSucceeded: function() {
    this.transitionTo('customers');
  },
  sessionAuthenticationFailed: function(error) {
    console.log('ko');
    this.send('authorizationFailed');
  }
});
