# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.CONVERTER = window.CONVERTER || {}


$ ->
  s = window.CONVERTER
  s.input_focus = 'fahrenheit'
  $('.c-active').css('visibility', 'hidden')

  s.clear = ->
    s.fahrenheit = ""
    s.centigrade = ""
    $('.disp').html('&nbsp;')

  s.clear()

  # calculate centigrade from fahrenheit
  s.calc_centigrade = () ->
    $('#fahrenheit').text(s.fahrenheit)
    if s.fahrenheit == '.' || s.fahrenheit == '-' || s.fahrenheit == '-.' # avoid NAN
      $('#centigrade').text(s.fahrenheit)
    else
      $('#centigrade').text(( (s.fahrenheit - 32)*5/9 ).toFixed(1) + "")

  # calculate fahrenheit from centigrade
  s.calc_fahrenheit = () ->
    $('#centigrade').text(s.centigrade)
    if s.centigrade == '.' || s.centigrade == '-' || s.centigrade == '-.' # avoid NAN
      $('#fahrenheit').text(s.centigrade)
    else
      $('#fahrenheit').text( ( (s.centigrade * 9 / 5) + 32).toFixed(1) + "")

  # handle minus-sign, don't allow more than one, always position at the front of the string
  # otherwise stick it at the beginning of the string and calculate the other value
  s.handle_minus = ()->
    if s.input_focus == 'fahrenheit'
      if /-/.test(s.fahrenheit)   # bail if we already have one minus sign
        return false
      s.fahrenheit =  "" + '-' + s.fahrenheit
      s.calc_centigrade()
    else
      if  /-/.test(s.centigrade)   # bail if we already have one minus sign
        return false
      s.centigrade = '-' + s.centigrade
      s.calc_fahrenheit()
    return true

  # don't allow more than one decmail-point in the input string
  s.handle_decimal = () ->
    if s.input_focus == 'fahrenheit'
      if /\./.test(s.fahrenheit) # bail if we already have one decimal point
        return false
      return s.handle_normal('.')
    else
      if /\./.test(s.centigrade) # bail if we already have one decimal point
        return false
      return s.handle_normal('.')

  # just stick the character on the end of the currently 'focussed'
  # input string and calculate the other value
  s.handle_normal = (c) ->
    if s.input_focus == 'fahrenheit'
      s.fahrenheit += c
      s.calc_centigrade()
    else
      s.centigrade += c
      s.calc_fahrenheit()
    return true



  # set the input focus for subsequent button clicks
  $('.data-display').click (ev)->
    if ev.target.id == 'fahrenheit'
      s.input_focus = 'fahrenheit'
      $('.f-active').css('visibility', 'visible')
      $('.c-active').css('visibility', 'hidden')
    else
      s.input_focus = 'centigrade'
      $('.f-active').css('visibility', 'hidden')
      $('.c-active').css('visibility', 'visible')

  # bind behavior to button clicks
  $(':button').click ->
    c = $(this).val()
    if c == 'c'
      s.clear()
    else if c == '-'
      return s.handle_minus()
    else if (c == '.')
      return s.handle_decimal()
    else
      return s.handle_normal(c)
