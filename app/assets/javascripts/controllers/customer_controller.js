App.CustomersController = Ember.ArrayController.extend({
  needs: ["application"],
  sortProperties: ["title"],
  sortAscending: true,
  isCreatingNew: false,

  actions: {
    createNew: function() {
      this.set('isCreatingNew', true);
    },
    hideCustomerForm: function() {
      this.set('isCreatingNew', false);
    },
    saveCustomer: function() {
      var customer = this.get('model');
      var _this = this;
      customer.save().then(function(session) {
        _this.get("controllers.application").notify({
          message: "The customer was saved",
          type: "success",
          persists: false
        });
        _this.set('isEditing', false);
        _this.set('isCreatingNew', false);
      }, function(error) {
        var message = "Errors: ";
        $.each(error.errors, function(key, value) {
          message = message + "#{key}: #{value}, ";
        });

        _this.get("controllers.application").notify({
          title: "The customer can't be saved",
          message: message,
          type: "alert",
          persists: false
        });
      });
    }
  }
});

App.CustomersNewController = Ember.ObjectController.extend({
  needs: ["application"],
  actions: {
    saveCustomer: function() {
      var customer = this.get('model');
      var _this = this;
      customer.save().then(function(session) {
        _this.get("controllers.application").notify({
          message: "The customer was saved",
          type: "success",
          persists: false
        })
      }, function(error) {
        var message = "Errors: ";
        $.each(error.errors, function(key, value) {
          message += "#{key}: #{value}, ";
        });
        _this.get("controllers.application").notify({
          title: "The customer can't be saved",
          message: message,
          type: "alert",
          persists: false
        })
      })
    }
  }
});

App.CustomerController = Ember.ObjectController.extend({
  needs: ["application"],
  isEditing: false,
  isCreatingNew: false,
  actions: {
    editCustomer: function() {
      this.set('isEditing', true);
    },
    showCustomer: function() {
      this.set('isEditing', false);
    },
    saveCustomer: function() {
      var customer = this.get('model');
      var _this = this;
      customer.save().then(function(session) {
        _this.get("controllers.application").notify({
          message: "The customer was saved",
          type: "success",
          persists: false
        });
        _this.set('isEditing', false);
        _this.set('isCreatingNew', false);
      }, function(error) {
        var message = "Errors: ";
        $.each(error.errors, function(key, value) {
          var message = message + "#{key}: #{value}, ";
        });
        _this.get("controllers.application").notify({
          title: "The customer can't be saved",
          message: message,
          type: "alert",
          persists: false
        });
      });
    },
    removeCustomer: function() {
      var customer = this.get('model');
      customer.deleteRecord();
      customer.save().then(this.transitionToRoute('customers'));
    },
    showDropdown: function() {
      Foundation.libs.dropdown.toggle($('#groupDropdownLink'));
    }
  }
});
