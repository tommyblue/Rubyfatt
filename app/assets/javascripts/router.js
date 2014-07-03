App.Router.map(function(){
  this.route('login');
  this.resource('customers', function(){
    this.resource('customer', { path: ':customer_id' });
    this.route('new');
  });
});

Ember.Route.reopen({
  activate: function(){
    this.controllerFor('application').closeNotification();
    this._super();
  }
});
