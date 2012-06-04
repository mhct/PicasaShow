### PicasaShow

06/04/2012
@mariohct

Realtime photo show for Google+ hangouts. People participating on a G+ hangout can see the same
photos at the same time, which are selected by a presenter. When the presenter selects a photo, 
everyone else participating on the G+ Hangout can also see that new photo.

As I live far from my family. I created this very tiny application to allow me to show photos to 
my family while seeing their reactions.


##### Installation

Currently you have to change a few files in order to deploy the application at your own servers. 
You also have to add your google ID, and the URL to the PicasaAlbum you want to show. This is done changing the
configuration code at the 

- Change the src/picasashow.html to reflect your the address of your own server

```html
<script type="text/javascript" src="http://people.cs.kuleuven.be/~mariohenrique.cruztorres/js/picasashow.js"></script>
<script src="http://people.cs.kuleuven.be/~mariohenrique.cruztorres/js/authCheck.js"></script>
```

- Change the src/picasashow.coffee file, adding your GooglePlusAPIKey
```coffeescript
googlePlusApiKey = 'AIzaSyC_Md4g5Gv5DA9FxtupQXsjOdOimg8HJPo'
```

##### APIs Documentation

- Picasaweb http://code.google.com/apis/picasaweb/docs/2.0/developers_guide_protocol.html#ListAlbumPhotos
- G+ hangouts https://developers.google.com/+/release-notes/hangouts#v1.0

##### Tools
- http://jsonviewer.stack.hu/

##### JS libraries
- http://highslide.com/
- http://code.google.com/p/pwi/
 
##### PICASAWEB API

list albums: 
https://picasaweb.google.com/data/feed/api/user/userID
https://picasaweb.google.com/data/feed/api/user/mario.hct?alt=json
feed.entry[i].id

EX: feed.entry[4].id =>
https://picasaweb.google.com/data/entry/api/user/108871109463531482000/albumid/5643547543866176097?alt=json


retrieve list of photos from one album: 
https://picasaweb.google.com/data/feed/api/user/userID/albumid/albumID?alt=json
ex: 


json: feed.entry[i].content
Parse URL and add "/s0/" before the image name, to get FULL resolution
EX:
https://lh6.googleusercontent.com/-wX6RiM1Qys0/TlHo4_fdnxI/AAAAAAAACEE/vAigVelHmD8/IMG_6146.JPG

https://lh6.googleusercontent.com/-wX6RiM1Qys0/TlHo4_fdnxI/AAAAAAAACEE/vAigVelHmD8/s0/IMG_6146.JPG
                                                                                    ^
                                                                                    |

GID: 590319610512
hangout url: https://plus.google.com/hangouts/_?gid=590319610512



