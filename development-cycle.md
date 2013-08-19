### Setting Up Your Environment

1. Fork and clone B2G and gaia
    - Relevant repos:
        - https://github.com/mozilla-b2g/B2G
        - https://github.com/mozilla-b2g/gaia
    - Add the upstreams:
        - `git remote add upstream https://github.com/mozilla-b2g/B2G`
        - `git remote add upstream https://github.com/mozilla-b2g/gaia`
    - In gaia, make remotes for bocoup team members
        - [example script](https://github.com/bocoup/gaia-notes/blob/master/gaia_remotes.sh)
2. Download and install Firefox Nightly
    - http://nightly.mozilla.org/
    - Copy your absolute path to the Firefox Nightly application for step 3 below
    - If you need to go back to a known good build for nightly:
        - Go to the nightly [FTP trunk](https://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/)
        - Look for folders ending in "mozilla-central"
        - eg. https://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/2013-07-19-03-02-04-mozilla-central/
3. Get Android Developer Tools
    - Windows or OSX
        - http://developer.android.com/sdk/index.html
        - On OS X you can download the sdk and add the `package-tools` folders to your `$PATH` in order to get [adb](http://developer.android.com/tools/help/adb.html). 
    - Linux
        - android-tools-* in your packages repo

### Flashing the Phone

To flash the phone, you need to get and setup the latest b2g18.

#### ONLY THE FIRST TIME

1. Get build dependencies
    - Build process: [Mozilla's B2G build instructions](https://github.com/mozilla-b2g/B2G/blob/master/README.md)
        - autoconf 2.13 can also be installed by using the [homebrew-versions](https://github.com/Homebrew/homebrew-versions) repo:
            - `brew tap homebrew/versions`
            - `brew install homebrew/versions/autoconf213`
2. Send Corey your **public** key for this to work (same place you get it for github, usually `~/.ssh`)  

        cd path/to/B2G
        scp nightly@cloud.gnarf.net:b2g18.tgz .
        
3. Extract the contents of b2g18.tgz. This will create a dir called `b2g18`, which contains a dir called `out`.
4. Copy the downloaded and extracted `b2g18/out` dir to your `B2G/` dir:  

        cd path/to/B2G
        cp -r b2g18/out out
        
5. Following the update of b2g18 (download or build), run the following:  

        cd path/to/B2G
        ./flash.sh

### Setting Up Your Phone

1. Enable developer debugging
    - Settings -> Device information -> More information -> Developer
        - Enable 'Remote debugging'
        - Enable 'Console enabled'
2. Quality of life changes:
    1. Disable screen sleep
        - Settings -> Display -> Screen timeout -> never
    2. Disable phone lock
        - Settings -> Phone lock -> Lock screen -> disable

### Deploying and Testing


#### Grab the latest from master

```bash
cd path/to/gaia
git checkout master
git pull upstream master
```

#### Make a change and test locally

1. Check out a new branch

        git checkout -b busted

2. Open editor, navigate to apps/clock/js
3. Open clock_view.js
4. Break something in the file, for example: comment out a big chunk of code
5. Make a debug profile

        make DEBUG=1
        
6. Launch Firefox Nightly with the newly created debug profile
        
        [/path/to]/firefox -profile [/path/to]/gaia/profile-debug http://test-agent.gaiamobile.org:8080

7. This will open FireFox Nightly, displaying the "test-agent"
    - if you want to see a specific app (e.g. clock), type `clock.gaigamobile.org:8080` into the url bar
8. Open the Console, uncheck the following noisy as hell items
    - Network
    - CSS
    - Security

#### Push change to the phone

```bash
make install-gaia APP=clock;
```

#### View logging from device!

```bash
adb-console;
```

#### Useful debugging functions you can make

1. Create a serialize.js

        touch shared/js/serialize.js

2. Put this inside:
    
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

3. In apps/clock/index.html insert: `<script src="shared/js/serialize.js"></script>`
4. In clock_view.js (anywhere, but the bottom seems convenient):

        var o = { foo: [1,2,3,4], bar: document.createElement('div') };
        log(o, ['bar']);


### General Notes About Branches and Bugs

Branch names should only be the bug number (ease of remembering and ease of pulling through CLI).  This also helps enforce mapping bugs to PRs.

e.g. `git pull rwaldron 12345`

or `git checkout -b 88712 rwaldron/88712` to create a new branch based off that person's current branch

### Rebasing

Master branch changes constantly (many, many times a day). A patch which could take 2 hours might find master branch changes underneath you.

From working branch (e.g. `busted`):

1. First attempt to rebase

```bash
git checkout -b busted-r1
git pull --rebase upstream master
```

2a. If no conflicts -->

```bash
git checkout busted
git pull --rebase upstream master
git branch -D busted-r1
```

2b. If conflicts, work them out with the other developer and repeat above

### Useful aliases for debugging/deploying

1. Copy Corey's .dotfiles/b2g.sh
    - https://github.com/gnarf/.dotfiles/blob/master/b2g.sh
        - Contains aliases for testing and running gaia in nightly
    - Make sure to update paths as needed:
        - check for absolute paths to Firefox Nightly
        - replace `gnarf` as needed, of course.
    - Linux Mint: 
        - add aliases in ~/.bashrc
    - Don't worry about B2G paths for right now

### Bugs, IRC, Mozilla Notes progress, etc....

1. Join irc.mozilla.org and join the following channels:
    - #gaia

2. Join bugzilla
    - Register at https://bugzilla.mozilla.org/
    - Save a search for your project:
        - [A sample Gaia Clock search](https://bugzilla.mozilla.org/buglist.cgi?list_id=7648569&columnlist=product%2Ccf_blocking_b2g%2Cbug_status%2Cresolution%2Cshort_desc&resolution=---&query_based_on=CLOCK&query_format=advanced&bug_status=UNCONFIRMED&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&component=Gaia%3A%3AClock&product=Boot2Gecko&known_name=CLOCK)
3. Keep weekly track of your work
    - Edit the document at [our internal wiki](https://github.com/bocoup/gaia-internal/wiki)
4. Track Gaia specs
    - Monitor the [Gaia specs](https://mozilla.app.box.com/s/wzgsb3lkqglv0dnfdgzs) page
