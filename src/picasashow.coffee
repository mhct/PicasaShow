#class Photo extends Backbone.Model
#    defaults:
#        "description": ""
#        "date": "undefined"
#    initialize: ->
#        @date = new Date(@get('date'))
 
#class PhotoView extends Backbone.View
#        tagName: 'photoContainer'
        
#        initialize: (@model) ->

#        render: ->
#                $(@el).html("<img src='" + @model.get('phtoUrl')+ "'/>")
#                return @

photos = []
photoIndex = 0

$ ->
        $('#testDiv').css 'background-color', 'green'
        albumUrl = 'https://picasaweb.google.com/data/feed/api/user/mario.hct/albumid/5643547543866176097'
        paramsUrl = {alt:'json'}

        $.getJSON(
                albumUrl,
                paramsUrl,
                (data) ->
                        buildAlbum entry for entry in data.feed.entry
                        showNextPhoto()
        )


buildAlbum = (entry) ->
        console.log "CONTENT: #{entry.content.src}"
        photos[photos.length] = entry.content.src
        
   
showNextPhoto = () ->
        console.log photos[photoIndex]
        $('#photoContainer').html("<img id='photoView' src='" + photos[photoIndex] + "' />")
        $('#photoView').click(-> showNextPhoto())
        photoIndex++
