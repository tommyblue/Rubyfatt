Ember.Application.initializer
  name: 'authentication'
  initialize: (container, application) ->
    Ember.SimpleAuth.setup(container, application)
