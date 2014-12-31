window.Admin or= {}

window.Admin.SortableGallery = class SortableGallery

  constructor:(@el)->
    @galleryForm = @el.find('.sortable-gallery-form')
    @gallery = @el.find '.photos'
    @photos = (new window.Admin.Photo($(photo)) for photo in @el.find('.photos .photo'))
    @mode = 'sort'
    @toggles = @el.find('.mode-toggle [type=radio]')
    @batchActions = @el.find('.batch-actions .btn')
    @applyHandlers()

  applyHandlers:->
    self = @

    @toggles.on 'change', (e)=>
      e.preventDefault()
      @toggleMode()

    @el.on 'click', '.photos .photo', (e)->
      e.preventDefault()
      $(this).trigger('select') if self.mode == 'select'
      self.toggleBatchActions()
    
    @gallery.sortable()
    .disableSelection()
    .on 'sortstop', (e)->
      # $(photo).find('input').val(i) for photo, i in self.gallery.find('.photo')
      # TODO: submit
      self.galleryForm.trigger('submit')


  toggleMode:=>
    @el.removeClass('select-mode sort-mode')
    @mode = if @mode == 'sort' then 'select' else 'sort'
    @el.addClass(@mode + '-mode')
    if @mode == 'sort'
      @deselectAllPhotos() 
      # @el.find('.photos .photo').prop('draggable', true)
      @gallery.sortable('enable')
    else
      @gallery.sortable('disable')
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