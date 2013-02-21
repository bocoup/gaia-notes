Pick an attachment:

```javascript
var pick = new MozActivity({
   name: "pick",
   data: {
       type: ["image/png", "image/jpg", "image/jpeg"]
    }
});

pick.onsuccess = function () { 
  // the blob
  this.result.blob;

  // make into a data uri
  var dataUri = window.URL.createObjectURL( this.result.blob );

  // and use the data uri, obvs
};

pick.onerror = function () { 
};
```

[the sms manifest file](https://github.com/mozilla-b2g/gaia/blob/master/apps/sms/manifest.webapp) needs to be updated with "messaging/message" or something as an activity.

The only registered activity stuff i can find is [here](https://github.com/mozilla-b2g/gaia/blob/master/apps/sms/js/sms.js#L1844) - which seems to do manual management of activities but doesn't use this api:

```javascript
var register = navigator.mozRegisterActivityHandler({
    name: "compose",
    disposition: "inline"
});

  register.onerror = function () {
}

navigator.mozSetMessageHandler("activity", function (data) { 
    /*
      Call data.postResult() or data.postError() if  
      the activity should return a value 
    */
});

composing a new message should support being sent a contact or being sent an image/video to send. maybe one activity? maybe two?
