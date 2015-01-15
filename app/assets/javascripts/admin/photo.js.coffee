window.Admin or= {}

window.Admin.Photo = class Photo extends window.Admin.SelectableListItem
  constructor:(@el=$('<li class="thumb photo ui-sortable-handle"> <div class="image-dummy"></div> <div class="progress-meter"></div> <input type="hidden" name="photo_ids[]"/> </li>'))->
    @progressMeter = @el.find('.progress-meter')
    super()

  progress:(percent)=>
    @progressMeter = @el.append("<div class='progress-meter'></div>") if @progressMeter.length == 0
    @progressMeter.height("#{100 - percent}%")
