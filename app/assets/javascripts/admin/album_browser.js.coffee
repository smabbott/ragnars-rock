window.Admin or= {}

window.Admin.AlbumBrowser = class AlbumBrowser 
  constructor:(@el, @fetchPhotos)->
    @albums = []
    @albumList = @el.find('.modal-body ul.albums')
    @albumPhotosList = @el.find('.modal-body ul.album-photos')
    @backLink = @el.find('.modal-header .back')
    @selectAll = @el.find('.modal-header .select-all')
    @selectNone = @el.find('.modal-header .select-none')
    @importSelected = @el.find('.modal-header .import-selected')
    @flash = $('<p class="flash"></p>')
    @el.find('.modal-body').append(@flash)
    @photoTemplate = $("#photo-template").html()
    Mustache.parse(@photoTemplate)
    @applyHandlers()
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

    # Nav
    @backLink.on 'click', (e)->
      e.preventDefault()
      self.albumPhotosList.hide()
      self.albumList.show()

    # SElection
    @selectAll.on 'click', (e)->
      e.preventDefault()
      self.albumPhotosList.find('li').addClass('selected')

    @selectNone.on 'click', (e)->
      e.preventDefault()
      self.albumPhotosList.find('li').removeClass('selected')

    @importSelected.on 'click', (e)->
      e.preventDefault()
      selected = self.albumPhotosList.find('li.selected input[name="photo_ids[]"]')
      console.log  selected

      # how can this be made asyc and in the background
      # make callbacks into named functions
      # TODO: initiate import
      # can something like s3_direct_upload be used for this? 
      # I bet it can. 
      # Use pusher to update user on progress

      # 1. fetch each photo (JSON) from FB
      selected.each (index, input)->
        FB.api "/#{$(input).val()}", 'GET', (res)->
          # 2. for each photo loop through it's images array
          maxIndex = 0
          currentMax = 0
          i = 0 
          for image in res.images 
            do (image)->
              if image.width > currentMax
                maxInex = i
                currentMax = image.width
              i++
          # 3. find the image with the largest width
          maxSource = res.images[maxIndex].source
          # 4. use the source property of that image to upload to the server
          $.post '/photos/', {photo:{location_id:window.Admin.locationId, remote_photo_url:maxSource}}, (res)->
            console.log res



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