#= require jquery
#= require jquery_ujs
#= require foundation
#= require handlebars
#= require ./components/ember-1.5.1
#= require ./components/ember-data-1.0.0
#= require_self
#= require ember-app

window.App = Ember.Application.create({
  LOG_TRANSITIONS: true
})

$(-> $(document).foundation())
