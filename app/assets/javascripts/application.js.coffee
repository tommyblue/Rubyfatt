#= require jquery
#= require jquery_ujs
#= require foundation
#= require handlebars
#= require ./components/ember-1.6.0
#= require ./components/ember-data-1.0.0
#= require_self
#= require ember-app
#= require ./tests/runner

window.App = Ember.Application.create
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_RESOLVER: true

$(-> $(document).foundation())
