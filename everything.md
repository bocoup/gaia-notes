# FirefoxOS, B2G, gaia and YOU

Getting setup for work on gaia

## Overview

FirefoxOS (or B2G - Boot To Gecko) is comprised of three core pieces. Gonk, Gaia and Gecko. 

Gonk is the core of the OS, consisting of a linux kernel and HAL layer (parts of which are shared with android for things like Camera, GPS, etc).

Gonk runs gecko, which is ported for use on Gonk. Just like gecko for OSX potentially has access to specific things like an accellerometer, Gecko has access to all of Gonk's unique features like the telephony stack, the GPS, and everything else unique about the device. 

What runs in Gecko is Gaia. This is the full UI for the device. Since the runtime is Gecko, Gaia is fully HTML/CSS/JavaScript and uses the APIs Gecko provides by the device/Gonk. There are also some special considerations regarding sandboxing apps and interapp communication, but those will be addressed later. 

## Getting started

Clone gaia somewhere sensible

```shell
git clone git://github.com/mozilla-b2g/gaia.git
```

While you _can_ build [B2G](https://github.com/mozilla-b2g/B2G) yourself (and you need to if you wish to flash a device with it), it's preferable to get started with the Desktop build. Also, it's much easier to work with. You can download an [already built Desktop build](http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/) for your specific operating system. 

#### Linux systems

Get the zip for your OS. We recommend developing with it adjacent to your gaia git clone. Which means your directory structure would look like this:

```
yourprojectdirectory/
  |-- gaia
  |-- b2g-nightly
      |-- # contents of zip file
      |-- b2g-bin
      |-- etc
```

### MacOS

This is similar, except the `dmg` comes as an app. Once you've mounted the `dmg`, you can drag it to your `Applications` folder. 
  
### Setup for working with B2G Desktop

`b2g-bin` is the executable you want. In linux, it's simply whereever you extracted the nightly file. In MacOS, it's in `/Applications/B2G.app/Contents/MacOS/b2g-bin`. Do yourself a favor and add that to your $PATH - either in your `.bashrc` or `.bash_profile` depending on your setup. Linux users, too. If you don't know how to do this, google "linux add to PATH" or "osx add to PATH". Moving foward, this document will assume you've done this. If you haven't, you can replace `b2g-bin` with the full path. 

So, now, you should be able to run `b2g-bin` and see a small, black window appear. You *might* even see B2G boot up, because it comes with an older version of gaia. But you want the latest gaia - the one you cloned earlier.

### Building Gaia

While Gaia is mostly HTML/CSS/JavaScript, there are still manifest files and configuration files that need to be built for XUL. To do this, simply type `make` in the root of the gaia directory. This will setup XUL and process gaia - namely all the apps in the `apps` folder. This creates a `profile` folder, which is the build version of gaia. 

To launch `b2g-bin` with your newly created profile, simply tell `b2g-bin` about it. 

```
b2g-bin -profile /path/to/gaia/profile
```

Note: `b2g-bin` requires that the path you give it to profile be a complete one. That means either one based off of the roo of the drive like `/path/to/gaia` or based off of your home folder `~/path/to/gaia`. A path like `../gaia/profile` will fail. 

So this should load B2G and start your profile for the first time. You'll probably get the welcoming questions like language and time-zone, as well as an optional tour. After that, you're in. Some tips for navigating in B2G desktop:

Home button: Home key (fn + ← on newer Mac Keyboards)
Power button: End key (fn + → on newer Mac Keyboards)
Volume button: Page Up/Down keys (fn + ↑/↓ on newer Mac Keyboards)
Open Cards View: long press to Home key (cmd + fn + ← on newer Mac Keyboards)

## Debugging Gaia in Desktop B2G

Of course, all you probably care about is running the debugger; as you should! Here's how you do it.

### The Dev Tools

Make sure you have [Firefox Aurora](http://www.mozilla.org/en-US/firefox/aurora/) or [Firefox Nightly](http://nightly.mozilla.org/) for the latest Dev Tools stuff. If you're curious how to run Firefox stable and Firefox Aurora together, check out how to [add and manage profiles](https://developer.mozilla.org/en-US/docs/Mozilla/Multiple_Firefox_Profiles). You can make a separate profile for each and opt to be prompted which profile to open when Firefox starts. 

Once you have it installed, open `about:config` and change the `devtools.debugger.remote-enabled` setting to true.

### Configuration

You need to build gaia with debugging enabled. Create a file in the `build` directory called `custom-prefs.js`. Here's what `/path/to/gaia/build/custom-prefs.js` should look contain:

```
user_pref("marionette.defaultPrefs.enabled", false);
user_pref("devtools.debugger.log", true);
user_pref("devtools.debugger.remote-enabled", true);
user_pref("devtools.debugger.force-local", false);
```

When you make gaia, specify you want debug mode. Do that with 

```
DEBUG=1 make
```

### Get your hands dirty

Fire up `b2g-bin` with your gaia profile. Once you've unlocked the screen in B2G desktop, open up the `Settings` App. The remote debugging is burried in `Settings > Device Information > More Information > Developer` and a toggle is present for `Remote Debugging`. Enable it. 

In Firefox, connect to the B2G desktop application by choosing `Connect...` in the `Tools > Web Developer` menu. Connect to `localhost` on port `6000` and you're all set!

### Asides

If you need to change the port for some reason (you already are using a service that requires that, albeit unlikely) you can change it in the `build/custom-prefs.js` file with `user_pref("devtools.debugger.remote-port", XXXX);` where XXXX is the port number. 


