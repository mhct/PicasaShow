#
# 18/04/2012
# @mariohct
#
photos = []
photoIndex = 0
googlePlusApiKey = 'AIzaSyC_Md4g5Gv5DA9FxtupQXsjOdOimg8HJPo'

onClientReady = ->
        console.log "jquery ready"
        gapi.hangout.onApiReady.add (eventObj) ->
                if eventObj.isApiReady
                        loadApp()

#
# The first to load the APP will be the PRESENTER of the slideshow
#
loadApp = ->
        gapi.client.setApiKey(googlePlusApiKey)
        window.setTimeout((-> checkAuth(true, (data) -> )), 1)

        keyMaster = gapi.hangout.data.getValue('master_already_present')

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
        $('#controlsContainer').html("PicasaAlbumUrl: <input type='text' id='albumUrl'/>&nbsp<input id='albumOk' type='button' value='OK'/>")
        $('#albumOk').click(-> loadAlbum())


loadAlbum = () ->
    #albumUrl = 'https://picasaweb.google.com/data/feed/api/user/mario.hct/albumid/5643547543866176097'
    #albumUrl = 'https://picasaweb.google.com/data/feed/api/user/danirigolin/albumid/5731743717515495073'
    #albumUrl = 'https://picasaweb.google.com/data/feed/api/user/mario.hct/albumid/5732154843755981809'
    #other https://picasaweb.google.com/data/feed/api/user/108871109463531482000/albumid/5732154843755981809
    albumUrl = $('#albumUrl').val()
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
                $('#photoContainer').html("<img id='photoView' src='#{currentPhotoUrl}'/>")
        )


buildAlbum = (entry) ->
        str = entry.content.src
        photos[photos.length] = str.substr(0,str.lastIndexOf("/")) + "/s0" + str.substr(str.lastIndexOf("/"), str.length)
        
   
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

window.onClientReady = onClientReady
