/** Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License
 */

// This is alpha code for using OAuth2 in a Hangout.
// It is likely that we will replace some or all of this functionality, and it
// depends on the JavaScript API Client, which is currently in alpha as well.

// API key from the Google API Console
// You can leave this as null if you are running inside the gadget.
var apiKey = 'AIzaSyC_Md4g5Gv5DA9FxtupQXsjOdOimg8HJPo';

// Lay out the hangout scopes here.
var scopes = ['https://www.googleapis.com/auth/plus.me',
	      'https://www.googleapis.com/auth/hangout.av',
	      'https://www.googleapis.com/auth/hangout.participants'];

/** Run authorization call in either with or without popup
 * @param {boolean} isImmediate Use immedate mode for authorization.
 */
function checkAuth(isImmediate) {
  console.log('checking auth');

  // Pass in a null client id; the gadget container will replace this
  // with a generated one.
  // HOWEVER!  You must go through the process of creating a client id
  // associated with this hangout app in the Google API console.
  gapi.auth.authorize({client_id: null,
          scope: scopes,
          immediate: isImmediate},
    handleAuthResult);
}

/** Callback from auth function
 * @param {object} authResult Return value from JS Client.
 */

function handleAuthResult(authResult) {
  var authorizeButton = document.getElementById('authorize-button');
  var tokenButton = document.getElementById('token-button');

  if (authResult) {
    authorizeButton.style.visibility = 'hidden';
    tokenButton.style.visibility = '';
    tokenButton.onclick = toggleTokenVisible;
    makeGPlusApiCall();
  } else {
    authorizeButton.style.visibility = '';
    tokenButton.style.visibility = 'hidden';
    authorizeButton.onclick = onAuthorizeClick;
  }
}

function onAuthorizeClick(event) {
  // non-immediate mode; i.e., pop up a dialog.
  checkAuth(false);
}

function toggleTokenVisible(event) {
  var tokenButton = document.getElementById('token-button');
  var tokenField = document.getElementById('token-field');

  if (tokenField.style.visibility == 'hidden') {
    tokenField.innerHTML = gapi.auth.getToken().access_token;
    tokenButton.innerHTML = 'Hide token';
    tokenField.style.visibility = '';
  } else {
    tokenButton.innerHTML = 'Show token';
    tokenField.style.visibility = 'hidden';
  }
}

function makeGPlusApiCall() {
  gapi.client.load('plus', 'v1', function() {
      var request = gapi.client.plus.people.get({
          'userId': 'me'
        });
      request.execute(function(resp) {
          var heading = document.createElement('h4');
          var nameHeading = document.createElement('h2');
          var image = document.createElement('img');

	  // Note that these values, URL and displayName
	  // are already visible in the Hangouts API 
	  // as part of the Participant data structure.
	  // We are using these ONLY as an example.
          image.src = resp.image.url;
          nameHeading.appendChild(document.createTextNode(resp.displayName));
          heading.appendChild(image);

          document.getElementById('content').appendChild(heading);
          document.getElementById('content').appendChild(nameHeading);

          document.getElementById('instructions').innerHTML = '';

        });
    });
}

/** Called when jsclient has fully loaded; sets API key */
//function onClientReady() {
//  gapi.hangout.onApiReady.add(function(event) {
//      console.log(event);
//      if (event.isApiReady) {

//        gapi.client.setApiKey(apiKey);
//        window.setTimeout(function() { checkAuth(true) }, 1);
//      }
//    });
//}
