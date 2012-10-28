allComponents = [
  'instagram',
  'twitter',
  'github',
  'lastfm',
  'foursquare',
  'steam',
  'contact',
  'projects'
]

spin_opts = {
  lines: 9,
  length: 5,
  width: 2,
  radius: 4,
  rotate: 9,
  color: '#4c4c4c',
  speed: 1.5,
  trail: 40,
  shadow: false,
  hwaccel: false,
  className: 'spinner',
  zIndex: 2e9
}


$url = null

window.adjustSelection = (component) ->
  $('.modal-backdrop').remove()

  for c in allComponents
    if c != component
      $('#' + c + '-profile').remove()

  $('.main-nav').children('li').removeClass('sel')
  $('#' + component + '-link').parent().addClass('sel')

  if component == 'home'
    $url = null


setupLinks = ->
  $('.main-nav a').click (e) ->
    if e.which == 2
      return

    if @href == $url
      return

    url = $.url(@href.replace('/#!', ''))
    $url = @href

    if @id == 'home-link' && window.location.pathname == '/'
       adjustSelection('home')
       linkSkip(e)
       return

    for component in allComponents
      if @id == component + '-link'
        adjustSelection(component)
        linkSkip(e)

        if $('#' + component + '-profile').length > 0
          window.location = @href
        else
          createModal(component)

    return

linkSkip = (e) ->
  e.preventDefault()
  e.stopPropagation()

createModal = (id) ->
  spinner = new Spinner(spin_opts).spin()
  $('#' + id + '-link').append(spinner.el)

  if id == 'projects' || id == "instagram"
    el = $('<div  class="profile ' + id + ' modal fade-large" id="' + id + '-profile"></div>')
  else
    el = $('<div  class="profile ' + id + ' modal fade" id="' + id + '-profile"></div>')

  el.load '/modal/' + id, ->
    spinner.stop()

  el.modal().on 'hidden', ->
      $(@).remove()
      adjustSelection('home')

$ ->
  setupLinks()
  adjustSelection('home')

$(document).on 'click', '#contact_submit', (e) ->
  $('.contact_send_feedback').fadeIn()
