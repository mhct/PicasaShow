### PicasaShow

06/04/2012
@mariohct

Realtime photo show for Google+ hangouts. People participating on a G+ hangout can see the same
photos at the same time, which are selected by a presenter.

As I live far from my family. I created this very tiny application to allow me to show  photos to my family and see their
to my photos, while I was showing them.



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



