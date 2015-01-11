window.Admin or= {}

window.Admin.SelectableListItem = class SelectableListItem
  constructor:->
    @el or= $('<li></li>')
    @selected = false
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