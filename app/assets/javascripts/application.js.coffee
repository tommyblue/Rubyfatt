#= require jquery
#= require jquery_ujs
#= require foundation
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require app

window.App = Ember.Application.create({
  LOG_TRANSITIONS: true
})

$(-> $(document).foundation())