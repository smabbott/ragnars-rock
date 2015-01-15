window.Admin or= {}

window.Admin.AlbumBrowser = class AlbumBrowser 
  constructor:(@el, @fetchPhotos)->
    @albums = []
    @albumList = @el.find('.modal-body ul.albums')
    @albumPhotosList = @el.find('.modal-body ul.album-photos')
    @applyHandlers()
    @flash = $('<p class="flash"></p>')
    @el.find('.modal-body').append(@flash)
    @photoTemplate = $("#photo-template").html()
    Mustache.parse(@photoTemplate)
    # back link
    # parent album
    # get image set
    

  applyHandlers:->
    self = @
    @el.on 'click', '.albums .album', (e)->
      e.preventDefault()
      # check to see if the gallery has been loaded yet. 
      # if not, fetch it.
      albumId = $(this).data('id')
      album = self.getAlbum albumId
      if album.photos.length == 0
        self.fetchPhotos albumId, (res)->
          album.photos.push(new window.Admin.Photo($(Mustache.render(self.photoTemplate, item)))) for item in res.data
          self.renderAlbum album
      else
        self.renderAlbum album

    @albumPhotosList.on 'click', '.photo', ->
      $(this).trigger('select')

  getAlbum:(id)->
    id = id.toString()
    album
    for a in @albums
      album = a if a.id == id
    album
  # render photos
  renderAlbum:(album)->
    # Clear out .albums or hide it and render/show .photos
    # items[] .source, place:{location:{city, country, latitude, longitude}}, name, created_time, images[6]
    @albumPhotosList.empty()
    @albumPhotosList.append(album.photos.map (photo)->
      photo.el
    )
    debugger
    @albumList.hide()
    @albumPhotosList.show()

  setAlbums:(albums)->
    @albumList.empty
    @albums = albums
    @albumList.append(@albums.map (album)-> 
      album.el
    )
    @albumList.show()
    @flash.hide()

  standby:(msg)->
    @albumList.hide()
    @albumPhotosList.hide()
    @flash.text(msg)
    @flash.show()

  show:->
    @el.modal('show')

  hide:->
    @el.modal('hide')