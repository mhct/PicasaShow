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

onClientReady = ->
        console.log "jquery ready"
        gapi.hangout.onApiReady.add (eventObj) ->
                if eventObj.isApiReady
                        loadApp()

#
# The first to load the APP will be the PRESENTER of the slideshow
#
loadApp = ->
        gapi.client.setApiKey(apiKey)
        #AIzaSyC_Md4g5Gv5DA9FxtupQXsjOdOimg8HJPo
        window.setTimeout((-> checkAuth(true)), 1)

        console.log "PicasaShow Ready"
        keyMaster = gapi.hangout.data.getValue('master_already_present')
        console.log "keyMaster: $#{keyMaster}$"

        if gapi.hangout.data.getValue('master_already_present') == 'true'
                clientApp()
        else
                masterApp()
        


masterApp = ->
        #
        # Sets as master in the shared object
        #
        gapi.hangout.data.setValue('master_already_present', 'true')

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

clientApp = ->
        gapi.hangout.data.onStateChanged.add( ->
                currentPhotoUrl = gapi.hangout.data.getValue('currentPhotoUrl')
                $('#photoContainer').html("<img id='photoView' src='#{currentPhotoUrl}' />")
        )


buildAlbum = (entry) ->
        console.log "CONTENT: #{entry.content.src}"
        photos[photos.length] = entry.content.src
        
   
showNextPhoto = () ->
        console.log photos[photoIndex]
        #
        # Adds photo url to the shared object
        #
        gapi.hangout.data.setValue('currentPhotoUrl', photos[photoIndex])

        #
        # Updates screen
        #
        $('#photoContainer').html("<img id='photoView' src='" + photos[photoIndex] + "' />")
        $('#photoView').click(-> showNextPhoto())
        photoIndex++

