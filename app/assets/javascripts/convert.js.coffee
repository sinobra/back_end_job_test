# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.CONVERTER = window.CONVERTER || {}


$ ->
  s = window.CONVERTER
  s.input_focus = 'upper_display'
  $('.c-active').css('visibility', 'hidden')

  s.selected_conversion = 'temperature
  '
  s.temperature = {}
  temp = s.temperature
  temp.clear = ->
    temp.fahrenheit = ""
    temp.centigrade = ""
    $('.disp').html('&nbsp;')


  # calculate centigrade from fahrenheit
  temp.calc_centigrade = () ->
    $('#upper_display').text(temp.fahrenheit)
    if temp.fahrenheit == '.' ||temp.fahrenheit == '-' ||temp.fahrenheit == '-.' # avoid NAN
      $('#lower_display').text(temp.fahrenheit)
    else
      $('#lower_display').text(( (temp.fahrenheit - 32)*5/9 ).toFixed(1) + "")

  # calculate fahrenheit from centigrade
  temp.calc_fahrenheit = () ->
    $('#lower_display').text(temp.centigrade)
    if temp.centigrade == '.' || temp.centigrade == '-' || temp.centigrade == '-.' # avoid NAN
      $('#upper_display').text(temp.centigrade)
    else
      $('#upper_display').text( ( (temp.centigrade * 9 / 5) + 32).toFixed(1) + "")

  # handle minus-sign, don't allow more than one, always position at the front of the string
  # otherwise stick it at the beginning of the string and calculate the other value
  temp.handle_minus = ()->
    if s.input_focus == 'upper_display'
      if /-/.test(temp.fahrenheit)   # bail if we already have one minus sign
        return false
      temp.fahrenheit = "" + '-' + temp.fahrenheit
      temp.calc_centigrade()
    else
      if  /-/.test(temp.centigrade)   # bail if we already have one minus sign
        return false
      temp.centigrade = "" + '-' + temp.centigrade
      temp.calc_fahrenheit()
    return true

  # don't allow more than one decmail-point in the input string
  temp.handle_decimal = () ->
    if s.input_focus == 'upper_display'
      if /\./.test(temp.fahrenheit) # bail if we already have one decimal point
        return false
      return temp.handle_normal('.')
    else
      if /\./.test(temp.centigrade) # bail if we already have one decimal point
        return false
      return temp.handle_normal('.')

  # just stick the character on the end of the currently 'focussed'
  # input string and calculate the other value
  temp.handle_normal = (c) ->
    if s.input_focus == 'upper_display'
      temp.fahrenheit += c
      temp.calc_centigrade()
    else
      temp.centigrade += c
      temp.calc_fahrenheit()
    return true



  # set the input focus for subsequent button clicks
  $('.data-display').click (ev)->
    if ev.target.id == 'upper_display'
      s.input_focus = 'upper_display'
      $('.f-active').css('visibility', 'visible')
      $('.c-active').css('visibility', 'hidden')
    else
      s.input_focus = 'lower_display'
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

  s.intialize = ->
    temp.clear()
    $('p#notes').html(s.temperature_text.notes)
    $('#upper_title').html(s.temperature_text.upper_title)
    $('#lower_title').html(s.temperature_text.lower_title)
    s.handle_normal = temp.handle_normal
    s.handle_minus = temp.handle_minus
    s.handle_decimal = temp.handle_decimal
    s.clear = temp.clear
  s.intialize()
