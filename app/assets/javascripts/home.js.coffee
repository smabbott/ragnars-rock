sidebar = {}
window.map
mapStyles = [{"featureType":"landscape","stylers":[{"saturation":-100},{"lightness":65},{"visibility":"on"}]},{"featureType":"poi","stylers":[{"saturation":-100},{"lightness":51},{"visibility":"simplified"}]},{"featureType":"road.highway","stylers":[{"saturation":-100},{"visibility":"simplified"}]},{"featureType":"road.arterial","stylers":[{"saturation":-100},{"lightness":30},{"visibility":"on"}]},{"featureType":"road.local","stylers":[{"saturation":-100},{"lightness":40},{"visibility":"on"}]},{"featureType":"transit","stylers":[{"saturation":-100},{"visibility":"simplified"}]},{"featureType":"administrative.province","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":-25},{"saturation":-100}]},{"featureType":"water","elementType":"geometry","stylers":[{"hue":"#333333"},{"lightness":-77},{"saturation":-100}]}]
initialize = ()->
  mapOptions = {
    center: 
      # TODO: location should be configurable
      lat:64.9498896 
      lng:-18.9058133 
    zoom: 6
    styles:mapStyles
  }
  # Create the map
  window.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

  # Add locations to it
  for location in window.locations
    marker = new google.maps.Marker
      position: new google.maps.LatLng(parseFloat(location.coordinates[0]), parseFloat(location.coordinates[1]))
      map: window.map
      title: location.name
      id: location.id
    google.maps.event.addListener marker, 'click', handleMarkerClick

handleMarkerClick = (e)->
  sidebar.show()
  $.get '/locations/' + this.id, (res)->
      sidebar.reset(res)
    ,"json"

google.maps.event.addDomListener(window, 'load', initialize)

$ ->
  sidebar = new Sidebar('#sidebar')

# TODO: give these classes their own file(s)
class Sidebar 
  constructor: (el)->
    @el = $(el)
    @photosList = @el.find('.photos')
    @soundsList = @el.find('.sounds')
    @closeButton = @el.find('.close')
    @closeButton.on 'click', @hide
    @sounds = []
    @photos = []
    @showing = false
    @

  # TODO: animate/slide-toggle
  show: =>
    @el.removeClass('hidden') if !@showing
    @showing = true

  hide: => 
    @el.addClass('hidden')    
    @showing = false if @showing

  reset: (location)->
    # TODO: init labels and nav with location data
    @photosList.empty()
    @addPhoto(photo) for photo in location.photos
    @soundsList.empty()
    @soundsPhoto(sound) for sound in location.sounds

  addPhoto: (photo)-> 
    photoObj = new Photo(photo)
    @photos.push(photoObj)
    @photosList.append(photoObj.render())

  addSound: (sound)-> 
    @soundsList.find(".sounds").append("<li><button class=\"btn-sound\" href=\"/sounds/" + sound.id + "\"/></li>") 

# TODO:
#   clear: ->
#     # remove all sounds and photos

class Medium
  constructor: (@medium)->
    @el = ""
    @

  addEventHandlers: =>
    @el.on 'click', 'button', @display
    @el.on 'mouseover', 'button', @hover
    @el.on 'mouseout', 'button', @unhover

  render: =>
    # TODO: animate: windowshade
    @el = @template()
    @addEventHandlers()
    @el

  hover: =>
    # Override me

  unhover: =>
    # Override me

  display: => 
    console.log 'display'
    console.log 'this is', @
    # TODO:
    console.log 'show big version of photo in main display area'


class Photo extends Medium
  constructor: (@photo)->
    super @photo

  # TODO: maybe use a html script template instead
  template: =>
    $("<li><button class=\"btn-photo\" href=\"/photos/" + @photo.id + "\" data-original-src=\"" + @photo.src + "\" data-hover-src=\"" + @photo.hover_src + "\" style='background-image:url(\"" + @photo.src + "\")'/></li>")

  hover: =>
    button = @el.find('button')
    button.css('background-image', "url(\"" + button.data('hover-src') + "\")")

  unhover: =>
    button = @el.find('button')
    button.css('background-image', "url(\"" + button.data('original-src') + "\")")


class Sound
  constructor: (@sound)->
    super @sound

  template: =>
    $("<li><button class=\"btn-sound\" href=\"/sound/" + @sound.id + "\"> " + @sound.name + " </li>")


