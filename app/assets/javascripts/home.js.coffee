canCreateLocation = false
editMode = false
$sidebar = {}
window.map
mapStyles = [{"featureType":"landscape","stylers":[{"saturation":-100},{"lightness":65},{"visibility":"on"}]},{"featureType":"poi","stylers":[{"saturation":-100},{"lightness":51},{"visibility":"simplified"}]},{"featureType":"road.highway","stylers":[{"saturation":-100},{"visibility":"simplified"}]},{"featureType":"road.arterial","stylers":[{"saturation":-100},{"lightness":30},{"visibility":"on"}]},{"featureType":"road.local","stylers":[{"saturation":-100},{"lightness":40},{"visibility":"on"}]},{"featureType":"transit","stylers":[{"saturation":-100},{"visibility":"simplified"}]},{"featureType":"administrative.province","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":-25},{"saturation":-100}]},{"featureType":"water","elementType":"geometry","stylers":[{"hue":"#333333"},{"lightness":-77},{"saturation":-100}]}]
initialize = ()->
  canvas = document.getElementById('map-canvas')
  if canvas?
    mapOptions = {
      center: 
        # TODO: location should be configurable
        lat:64.9498896 
        lng:-18.9058133 
      zoom: 6
      styles:mapStyles
      panControl:false
      streetViewControl:false
      mapTypeId: google.maps.MapTypeId.TERRAIN
      zoomControlOptions:
        style: 'SMALL'
    }
    # Create the map
    window.map = new google.maps.Map(canvas, mapOptions)
    google.maps.event.addListener map, 'click', addLocation

    # Add locations to it
    for location in window.locations
      marker = new google.maps.Marker
        icon: "/assets/icons/marker.png"
        position: new google.maps.LatLng(parseFloat(location.coordinates[0]), parseFloat(location.coordinates[1]))
        map: window.map
        title: location.name
        id: location.id
      google.maps.event.addListener marker, 'click', handleMarkerClick

handleMarkerClick = (e)->
  $sidebar.show()
  $.get '/locations/' + this.id, (res)->
      $sidebar.reset(res)
    ,"json"

addLocation = (e)->
  if editMode
    # navigate to new location page
    window.location.href = "locations/new?location[coordinates]=" + e.latLng.toString()

# addLocation = (e)->
#   if canCreateLocation
#     marker = new google.maps.Marker
#       position: e.latLng
#       map: window.map
#       title: "New Location"
#     google.maps.event.addListener marker, 'click', handleMarkerClick    
#     $sidebar.show()
#     $sidebar.reset({})

# only on right screen
google.maps.event.addDomListener(window, 'load', initialize)

$ ->
  if $('#map-canvas')
    canCreateLocation = window.currentUser?
    $addMarkerBtn = $('#add-marker-btn')
    $sidebar = new Sidebar('#sidebar')

    # TODO: move to a conditional admin js file
    toggleEditMode = (e)->
      if editMode
        editModeOff(e)
      else
        editModeOn(e)

    editModeOn = (e)->
      editMode = true
      window.map.setOptions({draggableCursor:"url(/assets/icons/new_marker.cur) 8 8, default";})

    editModeOff = (e)->
      editMode = false
      window.map.setOptions({draggableCursor:null;})    

    $addMarkerBtn.on 'click', toggleEditMode 


# TODO: give these classes their own file(s)
class Sidebar 
  constructor: (el)->
    @el = $(el)
    @locationName = @el.find('.location-name')
    @openWidth = '25%'
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
    if !@showing
      @el.width(0)
      @el.removeClass('hidden')
      @el.animate {width:@openWidth}, 200, 'swing', =>
        @showing = true

  hide: => 
    if @showing
      @el.animate {width:0}, 200, 'swing', =>
        @el.addClass('hidden')    
        @showing = false

  reset: (location)->
    # TODO: init labels and nav with location data
    @location ?= location
    @photos = []
    @sounds = []
    @photosList.empty()
    @addPhoto(photo) for photo in @location.photos
    @soundsList.empty()
    @soundsPhoto(sound) for sound in @location.sounds
    @locationName.text(@location.name)


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
    $("<li><button class=\"btn-photo\" href=\"/photos/" + @photo.id + "\" style='background-image:url(\"" + @photo.src + "\")'/></li>")

  hover: =>
    # button = @el.find('button')
    # button.css('background-image', "url(\"" + button.data('hover-src') + "\")")

  unhover: =>
    # button = @el.find('button')
    # button.css('background-image', "url(\"" + button.data('original-src') + "\")")


class Sound
  constructor: (@sound)->
    super @sound

  template: =>
    $("<li><button class=\"btn-sound\" href=\"/sound/" + @sound.id + "\"> " + @sound.name + " </li>")


