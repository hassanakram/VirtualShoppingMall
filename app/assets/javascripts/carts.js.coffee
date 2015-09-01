# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#checkout-cart').click (e)->
    unless $('input[name=checkout]').is(':checked')
      alert("Please indicate that you have read and agree to the Terms and Conditions and Privacy Policy")
      e.preventDefault()
