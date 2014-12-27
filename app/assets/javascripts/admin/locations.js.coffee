window.Admin or= {}

window.Admin.SortableGallery = class SortableGallery

  constructor:(@el)->
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

  toggleMode:=>
    @el.removeClass('select-mode, sort-mode')
    @mode = if @mode == 'sort' then 'select' else 'sort'
    @el.addClass(@mode + '-mode')

  toggleBatchActions:=>
    @batchActions.prop 'disabled', (@mode == 'sort')
    console.log 'toggle batch batch-actionss'

  # Photos 
  getPhotos:->
    @el.find('.photos .photo')

  getSelectedPhotos:->
    @el.find('.photos .photo.selected')    

  selectPhoto:(photo)->
    photo.select()


window.Admin.Photo = class Photo
  constructor:(@el)->
    @selected = false
    @applyHandlers()

  applyHandlers:->
    @el.on 'select', =>
      @toggleSelect()

  toggleSelect:->
    @selected = !@selected
    @el.toggleClass('selected')

$ ->
  gallery = new window.Admin.SortableGallery($('.gallery'))
