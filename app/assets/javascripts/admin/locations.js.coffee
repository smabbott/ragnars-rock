window.Admin or= {}

$ ->
  gallery = new window.Admin.SortableGallery($('.gallery'))

  $(".js-s3_file_field").each ->
    id = $(this).attr('id')
    $this = -> $("##{id}")
    $progress = $(this).siblings('.progress').hide()
    $meter = $progress.find('.meter')
    $(this).S3FileField
      add: (e, data) ->
        $progress.show()
        data.submit()
      done: (e, data) ->
        $progress.hide()
        $this().attr(type: 'text', value: data.result.url, readonly: true)
        console.log data.result
      fail: (e, data) ->
        alert(data.failReason)
      progress: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $meter.css(width: "#{progress}%")
