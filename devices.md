# Developing Firefox OS with mobile devices

### Flashing the Phone

To flash the phone, you need to get and setup the latest b2g.
You can either *build* b2g (optional) or just *download* b2g from gnarf.net

#### B2G Versions

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

#### Device Versions

<table>
  <thead>
    <tr>
      <th>Tracking Flag</th>
      <th>Model</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>unagi</td>
      <td>ZTE Maxiplus 5</td>
    </tr>  
    <tr>
      <td>inari</td>
      <td>ZTEOPEN</td>
    </tr>   
  </tbody>
</table>

#### (Option 1) Build B2G

##### Prerequisites

1. Get build dependencies as listed at: [Mozilla's B2G build instructions](https://github.com/mozilla-b2g/B2G/blob/master/README.md)
    - autoconf 2.13 can also be installed by using the [homebrew-versions](https://github.com/Homebrew/homebrew-versions) repo:
        - `brew tap homebrew/versions`
        - `brew install homebrew/versions/autoconf213`

##### Steps

1. Follow the build process at: [Mozilla's B2G build instructions](https://github.com/mozilla-b2g/B2G/blob/master/README.md)


#### (Option 2) Download appropriate build from mozilla's build servers
Corey, Mike and Rick have access to mozilla's build server. To get the latest build from 
mozilla ask one of them to fetch you a zip file of the latest build. When extract the mozilla 
builds will be extracted into a subfolder (unlike Cory's tgz packaged builds).

#### Mozilla has the following builds

<table>
  <thead>
    <tr>
      <th>Build Name</th>
      <th>Device</th>
      <th>Version</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>mozilla-central-inari-eng</td><td>ZTEOPEN (inari) [orange phone]</td><td>master</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-central-inari</td><td>ZTEOPEN (inari) [orange phone]</td><td>master</td> -->
    <!-- </tr> -->
    <tr>
      <td>mozilla-central-leo-eng</td><td>ZTE Maxiplus 5 (unagi)</td><td>master</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-central-leo</td><td>ZTE Maxiplus 5 (unagi)</td><td>master</td> -->
    <!-- </tr> -->
    <tr>
      <td>mozilla-central-hamachi-eng</td><td>Alcatel</td><td>master</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-central-hamachi</td><td>Alcatel</td><td>master</td> -->
    <!-- </tr> -->
    <!-- <tr> -->
    <!--   <td>mozilla-central-helix</td><td>?</td><td>master</td> -->
    <!-- </tr> -->
    <!-- <tr> -->
    <!--   <td>mozilla-central-mako</td><td>?</td><td>master</td> -->
    <!-- </tr> -->
    <tr>
      <td>mozilla-aurora-inari-eng</td><td>ZTEOPEN (inari) [orange phone]</td><td>1.2</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-aurora-inari</td><td>ZTEOPEN (inari) [orange phone]</td><td>1.2</td> -->
    <!-- </tr> -->
    <tr>
      <td>mozilla-aurora-leo-eng</td><td>ZTE Maxiplus 5 (unagi)</td><td>1.2</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-aurora-leo</td><td>ZTE Maxiplus 5 (unagi)</td><td>1.2</td> -->
    <!-- </tr> -->
    <tr>
      <td>mozilla-aurora-hamachi-eng</td><td>Alcatel</td><td>1.2</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-aurora-hamachi</td><td>Alcatel</td><td>1.2</td> -->
    <!-- </tr> -->
    <!-- <tr> -->
    <!--   <td>mozilla-aurora-helix</td><td>?</td><td>1.2</td> -->
    <!-- </tr> -->
    <tr>
      <td>mozilla-b2g18-inari-eng</td><td>ZTEOPEN (inari) [orange phone]</td><td>1.1</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-b2g18-inari</td><td>ZTEOPEN (inari) [orange phone]</td><td>1.1</td> -->
    <!-- </tr> -->
    <tr>
      <td>mozilla-b2g18-leo-eng</td><td>ZTE Maxiplus 5 (unagi)</td><td>1.1</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-b2g18-leo</td><td>ZTE Maxiplus 5 (unagi)</td><td>1.1</td> -->
    <!-- </tr> -->
    <tr>
      <td>mozilla-b2g18-hamachi-eng</td><td>Alcatel</td><td>1.1</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-b2g18-hamachi</td><td>Alcatel</td><td>1.1</td> -->
    <!-- </tr> -->
    <tr>
      <td>mozilla-b2g18_v1_0_1-inari-eng</td><td>ZTEOPEN (inari) [orange phone]</td><td>1.0</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-b2g18_v1_0_1-inari</td><td>ZTEOPEN (inari) [orange phone]</td><td>1.0</td> -->
    <!-- </tr> -->
    <tr>
      <td>mozilla-b2g18_v1_0_1-hamachi-eng</td><td>Alcatel</td><td>1.0</td>
    </tr>
    <!-- <tr> -->
    <!--   <td>mozilla-b2g18_v1_0_1-hamachi</td><td>Alcatel</td><td>1.0</td> -->
    <!-- </tr> -->
    <!-- <tr> -->
    <!--   <td>mozilla-b2g18_v1_1_0_hd-helix</td><td>?</td><td>1.0</td> -->
    <!-- </tr> -->
  </tbody>
</table> 


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

#### Stuck in FTU flow on the ZTE
If your radio doesn't work on the ZTE sometimes its possible to get stuck in the FTU flow 
while the device is looking for wireless networks.
This can be prevent you from getting to the settings to turn on remote debugging.
If this happens run the following command and restart the device. 
During startup for a short period, the phone is always reachable by adb.

```bash
adb wait-for-device ; adb shell stop b2g; NOFTU=1 make reset-gaia
```

### Setting Configurations for Gaia Build

1. Add a `custom-settings.json` file to the `gaia/build` folder and put this gist inside of it: [custom-settings.json](https://gist.github.com/gnarf/469fcae4c60c0517c0f9)
    - This file configures some gaia settings that make development turn-around times faster:
        - disables first time user experience (NOFTU=1)
        - enables remote debugging
        - etc
2. Every time you make changes to the `custom-settings.json` file, run `make clean`

#### Push app to the phone

```bash
make install-gaia APP=clock
```

#### Push sample user data onto the phone

To push some number of contacts / sms threads to the phone for testing:
- light = less data
- heavy = more data
- xheavy = even more data

```bash
 make reference-workload-(light|heavy|xheavy) APP=sms
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


