Ember.Handlebars.helper 'formatted_date', (value, options) ->
  return moment(value).lang("it").format('L')

Ember.Handlebars.helper 'formatted_datetime', (value, options) ->
  return moment(value).lang("it").format('LLL')
