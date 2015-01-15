window.Admin or= {}

$ ->
  gallery = new window.Admin.SortableGallery($('.gallery'))
  photoUploads = {}

  $(".disk-import-trigger").on 'click', ->
    $(".js-s3_file_field").click()    

  $(".js-s3_file_field").each ->
    id = $(this).attr('id')
    $this = -> $("##{id}")
    # $progress = $(this).siblings('.progress').hide()
    # $meter = $progress.find('.meter')
    $(this).S3FileField
      
      limitConcurrentUploads:3
      disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator && navigator.userAgent),
      previewMaxWidth: 100,
      previewMaxHeight: 100,
      previewCrop: true

      add: (e, data) ->
        photo = gallery.addPhoto()
        photoUploads[data.files[0].unique_id] = photo
        # Show a preview of the image while it is uploading
        reader = new FileReader();
        reader.onload = (e)->
          photo.el.find('.image-dummy').css({'background-image':'url(' + e.target.result + ')', 'background-size':'cover'})
        reader.readAsDataURL(data.files[0])
        photo.progress(0)
        data.submit()

      done: (e, data) ->
        # TODO:
        # submit data.result.url to /photos#create
        # assign data-id attribute to photo el
        # add hidden input for id
        $.post '/photos', {photo:{location_id:gallery.el.data('location'), remote_photo_url: data.result.url}}, (res)->
          # console.log res
          photo = photoUploads[data.files[0].unique_id] 
          photo.el.find('input').val(res.id)
        , 'json'

      fail: (e, data) ->
        alert(data.failReason)

      progress: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        # $meter.css(width: "#{progress}%")

        # console.log("progress for #{data.files[0].unique_id}")
        photoUploads[data.files[0].unique_id].progress(progress)

  albumBrowser = new window.Admin.AlbumBrowser $('#album-browser'), (id, cb)->
    # TODO: check to make sure this album hasn't been loaded already
    FB.api "/#{id}/photos", 'GET', cb

  $('.facebook-import-trigger').on 'click', ->
    window.fbLogin ->
      FB.api '/me/albums', (res)->
        albumBrowser.show()
        albumBrowser.standby('connecting to facebook...')
        # TODO: show a spinner
        # batch-fetch image paths to all of the album cover images
        albumNames = {}
        (albumNames[a.cover_photo] = {name:a.name, id:a.id}) for a in res.data
        albumRequests = []
        albumRequests.push({method: 'GET', relative_url:album.cover_photo}) for album in res.data
        FB.api '/', 'POST', {batch: albumRequests}, (albumCovers)->
          covers = []
          covers.push(JSON.parse(cover.body)) for cover in albumCovers
          albums = []
          # albums.push(new window.Admin.Album($("<li><figure><img src='#{album.picture}'/></figure><figcaption>#{albumNames[album.id]}</figcaption>"))) for album in covers
          albums.push(new window.Admin.Album(cover.picture, albumNames[cover.id].name, albumNames[cover.id].id)) for cover in covers
          albumBrowser.setAlbums(albums)
          # $('#album-browser .modal-body').append(al.el) for al in albums
