window.Admin or= {}

window.Admin.AlbumBrowser = class AlbumBrowser 
  constructor:(@el)->
    @alabums = []
    @list = @el.find('.modal-body ul.albums')
    @

  setAlbums:(albums)->
    @list.empty
    @albums = albums
    @list.append(@albums.map (album)-> 
      album.el
    )

  show:->
    @el.modal('show')

  hide:->
    @el.modal('hide')