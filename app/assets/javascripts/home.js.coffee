sidebar = {}
window.map
initialize = ()->
  mapOptions = {
    center: 
      lat:64.9498896 
      lng:-18.9058133 
    zoom: 6
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
    # TODO: simply create photo object. Let it take care of rendering itself
    # TODO: animate: windowshade
    @photosList.append("<li><button class=\"btn-photo\" href=\"/photos/" + photo.id + "\" style='background-image:url(\"" + photo.url + "\")'/></li>")

  addSound: (sound)-> 
    @soundsList.find(".sounds").append("<li><button class=\"btn-sound\" href=\"/sounds/" + sound.id + "\"/></li>") 

# TODO:
#   clear: ->
#     # remove all sounds and photos


# class Photo
#   constructor ->

# class Sound
#   constructor ->

