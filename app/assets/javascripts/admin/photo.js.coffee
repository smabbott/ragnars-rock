window.Admin or= {}

window.Admin.Photo = class Photo
  constructor:(@el=$('<li class="thumb photo ui-sortable-handle"> <div class="image-dummy"></div> <div class="progress-meter"></div> <input type="hidden" name="photo_ids[]"/> </li>'))->
    @selected = false
    @progressMeter = @el.find('.progress-meter')
    @applyHandlers()

  applyHandlers:->
    @el
    .on 'select', =>
      @toggleSelect()
    .on 'deselect', =>
      @el.removeClass('selected')

  toggleSelect:->
    @selected = !@selected
    @el.toggleClass('selected')

  progress:(percent)=>
    @progressMeter = @el.append("<div class='progress-meter'></div>") if @progressMeter.length == 0
    # @progressMeter.stop().animate({'height':"#{100 - percent}%"}, 50)
    @progressMeter.height("#{100 - percent}%")
