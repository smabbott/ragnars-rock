window.Admin or= {}

window.Admin.SortableGallery = class SortableGallery

  constructor:(@el)->
    @gallery = @el.find '.photos'
    @photos = (new window.Admin.Photo($(photo)) for photo in @el.find('.photos .photo'))
    @mode = 'sort'
    @toggles = @el.find('.mode-toggle [type=radio]')
    @batchActions = @el.find('.batch-actions .btn')
    @applyHandlers()

  applyHandlers:->
    @toggles.on 'change', @toggleMode
    self = @
    @el.on 'click', '.photos .photo', (e)->
      $(this).trigger('select') if self.mode == 'select'
      self.toggleBatchActions()
    
    @gallery.sortable()
    .disableSelection()
    .on 'sortstop', (e)->
      # console.log 'sort end'
      # TODO: trigger update of order of photos


  toggleMode:=>
    @el.removeClass('select-mode sort-mode')
    @mode = if @mode == 'sort' then 'select' else 'sort'
    @el.addClass(@mode + '-mode')
    if @mode == 'sort'
      @deselectAllPhotos() 
      # @el.find('.photos .photo').prop('draggable', true)
    else
      # @el.find('.photos .photo').prop('draggable', false)

  toggleBatchActions:=>
    self = @
    @batchActions.each ->
      $(this).prop 'disabled', self.getSelectedPhotos().length == 0

  # Photos 
  getPhotos:->
    @el.find('.photos .photo')

  getSelectedPhotos:->
    @el.find('.photos .photo.selected')    

  selectPhoto:(photo)->
    photo.select()

  deselectAllPhotos:->
    @getSelectedPhotos().each ->
      $(this).trigger('deselect')

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

$ ->
  gallery = new window.Admin.SortableGallery($('.gallery'))
