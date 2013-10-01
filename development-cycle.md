## B2G AND DEVICE VERSIONS

### B2G

<table>
  <thead>
    <tr>
      <th>Tracking Flag</th>
      <th>Version</th>
      <th>Branch</th>
      <th>Gecko</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>leo+</td>
      <td>v1.1</td>
      <td>v1.1</td>
      <td>gecko 18</td>
    </tr>  
    <tr>
      <td>koi+</td>
      <td>v1.2</td>
      <td>v1.2</td>
      <td>gecko 26</td>
    </tr>
    <tr>
      <td>v1.3+</td>
      <td>v1.3</td>
      <td>master</td>
      <td>gecko latest</td>
    </tr>    
  </tbody>
</table>

### Device

<table>
  <thead>
    <tr>
      <th>Model</th>
      <th>Tracking Name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>(the white one)</td>
      <td>unagi</td>
    </tr>  
    <tr>
      <td>ZTEOPEN</td>
      <td>inari</td>
    </tr>   
  </tbody>
</table>

## SET UP ENVIRONMENT AND PHONE

### Setting Up Your Environment

1. Fork and clone B2G and gaia
    - Relevant repos:
        - https://github.com/mozilla-b2g/B2G
        - https://github.com/mozilla-b2g/gaia
    - Add the upstreams:
        - `git remote add upstream https://github.com/mozilla-b2g/B2G`
        - `git remote add upstream https://github.com/mozilla-b2g/gaia`
    - In gaia, make remotes for bocoup team members
        - Rick has a [script](https://github.com/bocoup/gaia-notes/blob/master/gaia_remotes.sh) to provide shortcuts, but as repo names are case sensitive your needs (e.g. wanting all lowercase while working) may not fit the script as such.
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
        - On OS X you can download the sdk and add the `platform-tools` folders to your `$PATH` in order to get [adb](http://developer.android.com/tools/help/adb.html). 
    - Linux
        - android-tools-* in your packages repo
4. Download and install the closure linter `gjslint`
    - https://developers.google.com/closure/utilities/docs/linter_howto
5. Install the node dependencies for the test infrastructure
    - cd /path/to/gaia/tools/test-agent
    - npm install

### Flashing the Phone

To flash the phone, you need to get and setup the latest b2g18.
You can either *build* b2g18 (optional) or just *download* b2g18 from gnarf.net

#### (Option 1) Build B2G

##### Prerequisites

1. Get build dependencies as listed at: [Mozilla's B2G build instructions](https://github.com/mozilla-b2g/B2G/blob/master/README.md)
    - autoconf 2.13 can also be installed by using the [homebrew-versions](https://github.com/Homebrew/homebrew-versions) repo:
        - `brew tap homebrew/versions`
        - `brew install homebrew/versions/autoconf213`

##### Steps

1. Follow the build process at: [Mozilla's B2G build instructions](https://github.com/mozilla-b2g/B2G/blob/master/README.md)

#### (Option 2) Download appropriate build from gnarf.net

##### Prerequesities

1. Send Corey your **public** key for this to work (same place you get it for github, usually `~/.ssh`)  

##### Steps
        
1. Download appropriate build tar file for (version)-(phone).tgz

```bash   
cd path/to/B2G
scp nightly@cloud.gnarf.net:(version)-(phone).tgz .
```
Examples: 
```bash
scp nightly@cloud.gnarf.net:v1.1-unagi.tgz .
scp nightly@cloud.gnarf.net:v1.2-unagi.tgz .
scp nightly@cloud.gnarf.net:master-inari.tgz .
```

2. Extract the contents of `(version)-(phone).tgz`

```bash         
tar -zxvf (version)-(phone).tgz
```
Examples: 
```bash 
tar -zxvf v1.1-unagi.tgz
tar -zxvf v1.2-unagi.tgz
tar -zxvf master-inari.tgz
```        
        

#### Flash the phone

Note: You may need to edit the .config file to point the GECKO_OBJDIR to the objdir-gecko subfolder in the folder you cloned b2g to.
        
1. Following the update of B2G (download or build), run the following:  

        cd path/to/B2G
        ./flash.sh

   Or to just build the gecko layer
   
        ./flash.sh gecko

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

### Preparing Gaia

Once B2G is flashed, gaia needs to be reset. This only needs to be done _once_ following a freshly flashed B2G build.

1. Reset gaia

```bash
cd path/to/gaia;
make reset-gaia;
```

2. Repeat step 1 of [Setting Up Your Phone](https://github.com/bocoup/gaia-notes/blob/master/development-cycle.md#setting-up-your-phone)
3. Install gaia

```bash
make install-gaia;
```

## SET UP BUGZILLA, IRC, ETC.

1. Join irc.mozilla.org and join the following channels:
    - #gaia

2. Join Bugzilla
    - Register at https://bugzilla.mozilla.org/
    - Save a search for your project:
        - [A sample Gaia Clock search](https://bugzilla.mozilla.org/buglist.cgi?list_id=7648569&columnlist=product%2Ccf_blocking_b2g%2Cbug_status%2Cresolution%2Cshort_desc&resolution=---&query_based_on=CLOCK&query_format=advanced&bug_status=UNCONFIRMED&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&component=Gaia%3A%3AClock&product=Boot2Gecko&known_name=CLOCK)
    - Ask someone to get you permission to 'take' bugs
3. Keep weekly track of your work, internally for Bocoup
    - Edit 'Weekly Progress Notes' at [our internal wiki](https://github.com/bocoup/gaia-internal/wiki)
4. Track Gaia specs powerpoints for visual/interaction specifications
    - Monitor the [Gaia specs](https://mozilla.app.box.com/s/wzgsb3lkqglv0dnfdgzs) page
5. [Weekly Gaia meeting etherpad](https://etherpad.mozilla.org/gaia-meeting-notes)
6. Mozilla's performance test utility: [Datazilla](https://datazilla.mozilla.org/)
7. Join Dev-Gaia
    - [mozilla.dev.gaia Google Group](https://groups.google.com/forum/#!forum/mozilla.dev.gaia)

## FIXING BUGS AND MAKING PULL REQUESTS

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

#### To run the unit tests for an app from the command line (using Corey's functions from b2g.sh)

1. Start the test agent server
    - cd /path/to/gaia
    - make test-agent-server

2. Start an instance of gaia in firefox nightly 
    - You need to have a debug profile in your firefox for this to run. So if you haven't made one
        -  cd /path/to/gaia
        -  DEBUG=1 make
    - Run the gaia-test-latest function from b2g.sh. You probably want to background this to get your console back

3. Run the unit test
    - cd /path/to/gaia
    - gaia-unit APPNAME

The tests will then run. At this point for any failing tests the test server will be watching that file for changes and re-running that test on save.
If you add a new test file you need to restart the test-server.

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

### Making a Pull Request

##################
After fixing a bug
##################

### Try to rebase with upstream
- git checkout -b #####-r1
- git pull --rebase upstream master
- git checkout #####

### If rebase doesn't work, from #####-r#
- Resolve the conflict
- git add -i the file
- git rebase --continue
- git branch -D #####
- git checkout -b #####

### Stage the relevant files
- git add -i
- stage all the relevant files

### Commit and push the relevant files
- git commit -m "[copy of bug title]"
- git push

### Create pull request
- Go to: https://github.com/evhan55/gaia/compare/#####
- Click "Click to create a pull request for this comparison"
- Summarize everything you did
- Pull request will be created here: https://github.com/mozilla-b2g/gaia/pull/@@@@@

### Submit for review
- Go to: original bug at https://bugzilla.mozilla.org/show_bug.cgi?id=#####
- Click 'Add an attachment'
- Paste the github pull request url into first field
- Paste the github pull request url into second field
- Paste the summary from above into the 'comment' field
- Add 'review: ?' flag
- Choose the person assigned to review it
- Click "Submit"

### Wait for reviews

### Make changes to a patch and push again
- git commit -m "[copy of bug title]" --amend
- git push origin ##### -f


