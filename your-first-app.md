# Your First App
This guide shows you how to build and deploy a simple client-only Firefox OS application, to be installed from a third party source (AKA your Github Pages account and not the Marketplace). This guide assumes you have npm and a github account, as well as a working installation of B2G. You do _not_ need to be able to compile Gaia to get a third party app up and running.

This is a modified version of [Mozilla's weather app tutorial](https://developer.mozilla.org/en-US/docs/Apps/Tutorials/Weather_app_tutorial).

The overall steps for this tutorial are:

* Fork the example repo and clone it. 

## Fork the example repo and clone it

Go to [the example repo](https://github.com/dariusk/weatherme) and [fork_ it](https://github.com/dariusk/weatherme/fork_select) (don't just clone it). The reason you're forking rather than cloning is we're going to host this on your [Github Pages](http://pages.github.com/), which is Github's free hosting for your app. More on that when we get to the deployment phase below.

Once you've forked it, clone it and cd into the root directory for the app:

```
$ git clone git@github.com:YOURUSERNAME/weatherme.git
$ cd weatherme
```

## Install the dependencies

This app uses [volo](http://volojs.org/) to manage packages and the build/deploy process. (It uses Volo as opposed to, say, Grunt, because for now we're being consistent with what the Mozilla tutorial uses.)

To install Volo:

`$ npm install -g volo`

Next, install the project's dependencies as described in its package.json:

`$ npm install`

## Application contents

If you look at the `www/` directory you'll see the core structure of the app.

* `index.html`: The core html for the app.
* `js/app.js`: Where the code for the app's behavior lives.
* `manifest.webapp`: The manifest file that contains the metadata about your application as it will appear in the FirefoxOS UI. This include the app name, description, and the icon that it will be displayed with, among other things.
* `installer.html`: This is the page that we will point our web browser to in order to install the app. (More on this below, under "Install the app")

## See the app up and running

Volo will run a local web server for us:

`$ volo serve`

By default, this is serving the application content in `www/`. Now point a browser to [http://localhost:8008/](http://localhost:8008/). You should see "What's the Forecast?" with two tabs, for Forecast and Settings. You can set your own zip code or city under settings to get the high/low temp for today and tomorow.

Close the server (ctrl+c / cmd+c) for now.

## Build the app

Next up we build the app, which among other things minifies and concatenates all our JS files.

`$ volo build`

This will put the built contents into a directory called `www-build/`. If you like, you can inspect the contents of `www-build/js/app.js` and confirm that it's minified.

If you'd like to serve the built app, run:

`$ volo serve base=www-built`

And then check out [http://localhost:8008/](http://localhost:8008/) once again.

## Deploy the app

To deploy the app to your Github Pages, just run:

`$ volo ghdeploy`

It will ask you some questions (you can accept the defaults), and it will probably ask for your Github username and password. When it's done it will give you a success message along with a URL where the app will soon be hosted. It's probably something like:

`http://YOURUSERNAME.github.com/weatherme/`

Note: the first time you deploy this you'll need to wait 10-20 minutes for Github Pages to do whatever magic it does behind the scenes. Once you've done this the first time, successive deployments will be fine.

## Install the app

Now you get to install it! Launch B2G Desktop, or Firefox OS Simulator, or probably even a real phone with FirefoxOS on it. Open up the web browser and point it to:

`http://YOURUSERNAME.github.com/weatherme/installer.html`

Then click 'Install!' and it should prompt you to install the app. Run the app and voila, there it is!

What's happening here is the install link runs this script (modified from [this tutorial app](https://github.com/darkwing/html5apptut/blob/master/installer.html)):

```javascript
function install() {
  // Total hack due to this bug that prevents relative path for mozApps.install: https://bugzilla.mozilla.org/show_bug.cgi?id=745928
  var r = navigator.mozApps.install(location.protocol + "//" + location.host + location.pathname.replace('/installer.html','') + "/manifest.webapp");
  
  console.warn(r);
  
  r.onsuccess = function () {
    // Save the App object that is returned
    var appRecord = this.result;
    alert('Installation successful!')
  };
  r.onerror = function () {
    alert('Install failed, error: ' + this.error.name);
  };
}
```

The one weird thing about this is what we're passing to `navigator.mozApps.install`. That function accepts an absolute path to a manifest file. It has to be an absolute path at the moment because that's the simplest way to prevent someone from spoofing a different manifest. So you can't pass a relative path to mozApps.install, and [there's an open bug about this](https://bugzilla.mozilla.org/show_bug.cgi?id=745928). For now the workaround is to use `location` parameters to artifically build the path to the manifest (or hardcode it into the installation function, boo).

## Hooray!

You've now installed your first hosted app on FirefoxOS!

Your next assignment: make some changes to `index.html`, or anything else, then `volo serve` to check your work, and redeploy:

```
$ volo build
$ volo ghdeploy
```

That should instantly update your app.

(TODO: figure out how to update an app! Right now I'm deleting and reinstalling.)
https://developer.mozilla.org/en-US/docs/Apps/Updating_apps
