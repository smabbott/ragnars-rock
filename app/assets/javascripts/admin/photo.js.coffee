window.Admin or= {}

window.Admin.Photo = class Photo
  constructor:(@el)->
    @selected = false
    @applyHandlers()

  applyHandlers:->
    @el
    .on 'select', =>
      @toggleSelect()
    .on 'deselect', =>
      @el.removeClass('selected')

    # .on 'dragstart', ->
    #   console.log 'drag start'
    # .on 'dragenter', (e)->
    #   console.log 'drag enter'
    # .on 'dragleave', ->
    #   console.log 'drag leave'
    #   $(this).css('margin-left', '0px')
    # .on 'drop', ->
    #   console.log 'drag drop'
    # .on 'dragend', ->
    #   console.log 'drag end'
    #   # .on 'drag', ->
    #   #   console.log 'drag'
    # .on 'dragover', ->
    #   $(this).css('margin-left', '50px')
    #   console.log 'drag over'



  toggleSelect:->
    @selected = !@selected
    @el.toggleClass('selected')