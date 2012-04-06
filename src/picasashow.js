$(document).ready(function() {
         
    $('#testDiv').html("MARIO");

    $.get("https://picasaweb.google.com/data/feed/api/user/mario.hct/albumid/5643547543866176097", buildPhotosCollection(data));

});

function buildPhotosCollection(data) {
    

    for(photoURL in photosCollection) {
    }
}        

