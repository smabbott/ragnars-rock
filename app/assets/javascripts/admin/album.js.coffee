window.Admin or={}

# TODO: set image and name
# use templates from markup rather than strings
window.Admin.Album = class Album extends window.Admin.SelectableListItem
  constructor:(src, name)->
    # @el=$('<li class="thumb album"> <figure><div class="image-dummy" style:"background-image:url(' + escape(src) + ')"></div><figcaption></figcaption></figure></li>')
    @el=$('<li class="thumb album"> <figure><div class="image-dummy" style="background-image:url(\'' + src + '\');"></div><figcaption>' + name + '</figcaption></figure></li>')
    super()

