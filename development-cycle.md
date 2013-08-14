### Setting Up Your Environment

1. Fork and clone B2G and gaia
    - Relevant repos:
        - https://github.com/mozilla-b2g/B2G
        - https://github.com/mozilla-b2g/gaia
    - Add the upstreams:
        - `git remote add upstream https://github.com/mozilla-b2g/B2G`
        - `git remote add upstream https://github.com/mozilla-b2g/gaia`
    - In gaia, make remotes for bocoup team members
        - https://gist.github.com/rwldrn/6185286
2. Download and install Firefox Nightly
    - http://nightly.mozilla.org/
    - Copy your absolute path to the Firefox Nightly application for step 3 below
    - If you need to go back to a known good build for nightly:
        - https://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/
        - Look for folders ending in "mozilla-central"
        - eg. https://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/2013-07-19-03-02-04-mozilla-central/
3. Copy Corey's .dotfiles/b2g.sh
    - https://github.com/gnarf/.dotfiles/blob/master/b2g.sh
    - Make sure to update paths as needed (check for absolute paths to Firefox Nightly)
    - Don't worry about B2G paths for right now
4. Get Android Developer Tools
    - Windows or OSX
        - http://developer.android.com/sdk/index.html
    - Linux
        - android-tools-* in your packages repo

### Setting Up Your Phone

1. Disable screen sleep
    - Settings -> Display -> Screen timeout -> never
2. Disable phone lock
    - Settings -> Phone lock -> Lock screen -> disable
3. Enable developer debugging
    - Settings -> Device information -> More information -> Developer
        - Enable 'Remote debugging'
        - Enable 'Console enabled'

### Flashing the Phone

To flash the phone, you need to get and setup the latest b2g18.

0. ONLY THE FIRST TIME...
    - Build process: https://github.com/mozilla-b2g/B2G/blob/master/README.md 
    - TODO: write a little script to check for the dependencies
1. Send Corey your public key for this to work (same place you get it for github, usually `~/.ssh`)
        ```bash
        % cd path/to/B2G;

        % scp nightly@cloud.gnarf.net:b2g18.tgz .
        ```
2. Extract the contents of b2g18.tgz. This will create a dir called "b2g18", which contains a dir called "out"
3. Copy the downloaded and extracted b2g18/out dir to your B2G/ dir:
        ```bash
        % cd path/to/B2G;

        % cp -r b2g18/out out;
        ```
4. Following the update of b2g18 (download or build), run the following: 
        ```bash
        % cd path/to/B2G;

        % ./flash.sh;
        ```

### Deploying and Testing


1. Pushing To Device

```bash
cd path/to/gaia;

git checkout master; git pull upstream master;
```

Tutorial Time!

```bash
git checkout -b busted;
```

Open editor, navigate to apps/clock/js

Open clock_view.js

Break something

```bash
make DEBUG=1; gaia-test;
```

This will open FireFox Nightly, displaying the "test-agent"

Open the Console, uncheck the following noisy as hell items:
    
    - Network
    - CSS
    - Security
    -  
    
```bash
make install-gaia APP=clock;
```

View logging from device!
```bash
adb-console;
```

Useful functions...

```bash
touch shared/js/serialize.js
```

put this inside:
    
```js    
function serialize(object, omission) {
  var o = {};
  if (Array.isArray(object)) {
    return JSON.stringify(object);
  }
  omission = omission || [];
  for (var p in object) {
    if (omission.indexOf(p) === -1) {
      o[p] = object[p];
    }
  }
  return JSON.stringify(o);
}

function log(object, omission) {
  console.log(serialize(object, omission));
}
```

then, in apps/clock/index.html...

<script src="shared/js/serialize.js"></script>


Inside of clock_view.js (anywhere, but the bottom seems convenient):

```js
var o = { foo: [1,2,3,4], bar: document.createElement('div') };
log(o, ['bar']);
```


### General Notes About Branches and Bugs

Branch names should only be the bug number (easy of remembering and ease of pulling through CLI).  This also helps enforce mapping bugs to PRs.

e.g. `git pull rwaldron 12345`

### Rebasing

Master branch changes constantly (many, many times a day). a patch which could take 2 hours might find master branch changes underneath you.

From working branch:

1. First attempt to rebase

```bash
git checkout -b busted-r1
git pull --rebase upstream master
```

if no conflicts -->

```bash
git checkout busted
git pull --rebase upstream master
git branch -D busted-r1
```
