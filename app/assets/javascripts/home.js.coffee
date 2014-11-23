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
    console.log location
    marker = new google.maps.Marker
      position: new google.maps.LatLng(parseFloat(location.coordinates[0]), parseFloat(location.coordinates[1]))
      map: window.map
      title: location.name
      id: location.id
    google.maps.event.addListener marker, 'click', handleMarkerClick

handleMarkerClick = (e)->
  $.get '/location/' + e.id, (res)->
    # pass res (data) to sidebar object

google.maps.event.addDomListener(window, 'load', initialize)

# class Sidebar = 
#   constructor ->
#     # reset

#   addPhoto: (photo)-> 
#     # render a photo and push object to photos array

#   addSound: (sound)-> 
#     # render a photo and push object to photos array

#   clear: ->
#     # remove all sounds and photos

#   reset: ->
#     # clear
#     # given arrays for photos and sounds fill those arrays

# class Photo
#   constructor ->

# class Sound
#   constructor ->

