# FirefoxOS, B2G, gaia and YOU

Getting setup for work on gaia

## Overview

FirefoxOS (or B2G - Boot To Gecko) is comprised of three core pieces. Gonk, Gaia and Gecko. 

Gonk is the core of the OS, consisting of a linux kernel and HAL layer (parts of which are shared with android for things like Camera, GPS, etc).

Gonk runs gecko, which is ported for use on Gonk. Just like gecko for OSX potentially has access to specific things like an accellerometer, Gecko has access to all of Gonk's unique features like the telephony stack, the GPS, and everything else unique about the device. 

What runs in Gecko is Gaia. This is the full UI for the device. Since the runtime is Gecko, Gaia is fully HTML/CSS/JavaScript and uses the APIs Gecko provides by the device/Gonk. There are also some special considerations regarding sandboxing apps and interapp communication, but those will be addressed later. 

## Key URLs

- Gaia
  - Source: https://github.com/mozilla-b2g/gaia
  - Bug tracker: https://bugzilla.mozilla.org/buglist.cgi?product=Boot2Gecko;component=Gaia;resolution=---;list_id=5625662
  - Forum: https://groups.google.com/forum/?fromgroups#!forum/mozilla.dev.gaia
- B2G
  - Nightly builds: http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/
  - Source: https://github.com/mozilla-b2g/B2G
  - Forum: https://groups.google.com/forum/?fromgroups#!forum/mozilla.dev.b2g
