$(document).on 'turbolinks:before-cache', ->
  $('.chosen-select').chosen("destroy")
  
$(document).on 'turbolinks:load', ->
  # enable chosen js
  $('.chosen-select').chosen
    width: '100%'
