# Getting started

You will need both B2G and Gaia to begin development. This guide assumes your
system is either Mac or Linux.

## Setup for working with B2G Desktop

While you _can_ build [B2G](https://github.com/mozilla-b2g/B2G) yourself (and
you need to if you wish to flash a device with it), it's preferable to get
started with the Desktop build. Also, it's much easier to work with. You can
download an [already built Desktop
build](http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/)
for your specific operating system.

`b2g-bin` is the executable you want. In linux, it's simply whereever you
extracted the nightly file. In MacOS, it's in
`/Applications/B2G.app/Contents/MacOS/b2g-bin`. Do yourself a favor and add
that to your $PATH - either in your `.bashrc` or `.bash_profile` depending on
your setup. Linux users, too. If you don't know how to do this, google "linux
add to PATH" or "osx add to PATH". Moving foward, this document will assume
you've done this. If you haven't, you can replace `b2g-bin` with the full path. 

So, now, you should be able to run `b2g-bin` and see a small, black window
appear. You *might* even see B2G boot up, because it comes with an older
version of gaia. But you want the latest gaia - see the next section for more
on this.

### Linux systems

Get the zip for your OS. We recommend developing with it adjacent to your gaia
git clone. Which means your directory structure would look like this:

```
yourprojectdirectory/
  |-- gaia
  |-- b2g-nightly
      |-- # contents of zip file
      |-- b2g-bin
      |-- etc
```

### MacOS

This is similar, except the `dmg` comes as an app. Once you've mounted the
`dmg`, you can drag it to your `Applications` folder.

## Building Gaia

Clone gaia somewhere sensible

```shell
git clone git://github.com/mozilla-b2g/gaia.git
```

While Gaia is mostly HTML/CSS/JavaScript, there are still manifest files and
configuration files that need to be built for XUL. To do this, simply type
`make` in the root of the gaia directory. This will setup XUL and process gaia
--namely all the apps in the `apps` folder. This creates a `profile` folder,
which is the build version of gaia.

To launch `b2g-bin` with your newly created profile, simply tell `b2g-bin`
about it.

```
b2g-bin -profile /path/to/gaia/profile
```

Note: `b2g-bin` requires that the path you give it to profile be a complete
one. That means either one based off of the root of the drive like
`/path/to/gaia` or based off of your home folder `~/path/to/gaia`. A path like
`../gaia/profile` will fail.

So this should load B2G and start your profile for the first time. You'll
probably get the welcoming questions like language and time-zone, as well as an
optional tour. After that, you're in. Some tips for navigating in B2G desktop:

Home button: Home key (fn + ← on newer Mac Keyboards)
Power button: End key (fn + → on newer Mac Keyboards)
Volume button: Page Up/Down keys (fn + ↑/↓ on newer Mac Keyboards)
Open Cards View: long press to Home key (cmd + fn + ← on newer Mac Keyboards)
