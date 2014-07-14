App.CustomersRoute = Ember.Route.extend(Ember.SimpleAuth.AuthenticatedRouteMixin, {
  model: function() {
    this.store.find('customer');
  }
});

App.CustomerRoute = Ember.Route.extend(Ember.SimpleAuth.AuthenticatedRouteMixin, {
  model: function(params) {
    this.store.find('customer', params.customer_id);
  }
});

App.CustomersNewRoute = Ember.Route.extend(Ember.SimpleAuth.AuthenticatedRouteMixin, {
  model: function() {
    this.store.createRecord('customer');
  }
});
