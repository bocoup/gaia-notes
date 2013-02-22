# Debugging Gaia in Desktop B2G

Of course, all you probably care about is running the debugger; as you should!
Here's how you do it.

## The Dev Tools

Make sure you have [Firefox
Aurora](http://www.mozilla.org/en-US/firefox/aurora/) or [Firefox
Nightly](http://nightly.mozilla.org/) for the latest Dev Tools. If you're
curious how to run Firefox stable and Firefox Aurora together, check out how to
[add and manage
profiles](https://developer.mozilla.org/en-US/docs/Mozilla/Multiple_Firefox_Profiles).
You can make a separate profile for each and opt to be prompted which profile
to open when Firefox starts. 

Once you have it installed, open `about:config` and change the
`devtools.debugger.remote-enabled` setting to true.

## Configuration

You need to build gaia with debugging enabled. Create a file in the `build`
directory called `custom-prefs.js`. Here's what
`/path/to/gaia/build/custom-prefs.js` should look contain:

```
user_pref("marionette.defaultPrefs.enabled", false);
user_pref("devtools.debugger.log", true);
user_pref("devtools.debugger.remote-enabled", true);
user_pref("devtools.debugger.force-local", false);
```

When you make gaia, specify you want debug mode. Do that with:

```
DEBUG=1 make
```

## Get your hands dirty

### Using FireFox 18

To work on a specific application, it may be preferable to work in FireFox 18.
This provides access to FireFox's full suite of developer tools, operating in
the context of the application.

To use FireFox 18, run the application from the command line, specifying the
absolute path to your Gaia profile as follows:

    $ /path/to/firefox-18 -profile /absolute/path/to/gaia/profile/

Next, navigate to the application's URL. Application URLs are structured as
follows:

    http://{ application name }.gaiamobile.org:8080/

For example, the home screen application can be accessed by visiting:

    http://homescreen.gaiamobile.org:8080/

### Using B2G-Desktop

B2G-Desktop is necessary to facilate development across applications.

Fire up `b2g-bin` with your gaia profile. Once you've unlocked the screen in
B2G desktop, open up the `Settings` App. The remote debugging is burried in
`Settings > Device Information > More Information > Developer` and a toggle is
present for `Remote Debugging`. Enable it.

In Firefox, connect to the B2G desktop application by choosing `Connect...` in
the `Tools > Web Developer` menu. Connect to `localhost` on port `6000` and
you're all set! If you don't see `Connect`, turn on remote debugging in Firefox
in `about:config` and toggle `devtools.debugger.remote-enabled` to true.

Once you've hit `Connect` in Firefox, you should see a prompt in B2G Desktop that
asks if you want to allow the debugger to connect. Allow it, and then go back to Firefox.
There should now be `chrome://browser/content/shell.xul` visible on the Connect page,
which you'll click to get a console.

A good query to test the console is to make sure B2G is on the homescreen (where the clock/date
appear). Enter the following:

```
document.childNodes[0].children[4].contentDocument.activeElement.contentDocument.querySelector("#landing-date").innerHTML
```

That should give you today's date as displayed on the homescreen. (So `document.childNodes[0].children[4].contentDocument.activeElement.contentDocument`
is the context of the active application that is currently on the screen, and you can go from there.)
Note that if you inspect an object, its inspection window may appear behind the console itself.

## Asides

If you need to change the port for some reason (you already are using a service
that requires that, albeit unlikely) you can change it in the
`build/custom-prefs.js` file with `user\_pref("devtools.debugger.remote-port",
XXXX);` where XXXX is the port number.

### Specific steps for getting it to work on Linux (Ubuntu 12.04 LTS x86-64)

* Download FireFox Aurora (Intel 64) from http://aurora.mozilla.org/ -- in
  this case, 21.0a1 (2013-02-07)
* Remove the "gaia" directory: `rm -rf gaia/`
* Re-clone the repository: git clone git@github.com:mozilla-b2g/gaia.git gaia
* Modify file `gaia/apps/homescreen/index.html` to show something different
  from a stock build
* Add these lines to ```gaia/build/custom-prefs.js```:

    user_pref("marionette.defaultPrefs.enabled", false);
    user_pref("devtools.debugger.log", true);
    user_pref("devtools.debugger.remote-enabled", true);
    user_pref("devtools.debugger.force-local", false);

* Run `make` with the debug flag: `/gaia $ DEBUG=1 make` *important note: don't
  even try a regular (non-debug) make, it won't work*
* Run the nightly b2g build from 2013-02-07: `_b2g_feb7 $ ./b2g-bin -profile
  /home/dariusk/Projects/Mozilla/gaia/profile/`
* Navigate to homescreen, confirm the change
* Navigate to Settings -> Device info -> More info -> Developer -> Remote
  Debugger
* Run Firefox Aurora. Navigate to Tools -> Web Developer -> Connect...
* Select "connect"
* Select the OK button which immediately appears in a prompt on the Firefox OS
  b2g-desktop simulator
* Select `chrome://browser/content/shell.xul` in FireFox. This should spawn a
  console window.
* Ensure you're on your home screen
* Execute the following JavaScript in the console:
  `document.childNodes[0].querySelector("#homescreen");`. This should return an
  Iframe element. If you click on the Iframe element it will launch an object
  inspector BEHIND the console window.
* Also, while on the homescreen, try:
  ```document.childNodes[0].children[4].contentDocument.activeElement.contentDocument.querySelector("#landing-date").innerHTML```.
  This should return the date as displayed on the homescreen.
