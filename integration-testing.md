## Integration Testing 

Gaia Integration tests use
[marionette](http://lightsofapollo.github.io/marionette_js_client/api-docs/) to
drive the B2G emulator and make assertions about the state of the application.

Marionette's [JavaScript
module](https://github.com/lightsofapollo/marionette_js_client) runs in a Node
enviroment and can be used to make issue commands to drive the B2G emulator.

### Running the Marionette integration tests

Run all tests:

```bash
$ make test-integration
```

Run specific tests:

```bash
./bin/gaia-marionette path/to/test-file;
# Example
./bin/gaia-marionette apps/clock/test/marionette/
```

### Writing your own Marionette Integration Tests

Integration tests typically go in the marionette folder within your apps test folder.
This folder will tipically contrain your tests files which will all end in `_test.js` and a `/lib` directory. 
The `/lib` directory contains helper modules that may be required by tests. At a minimum the tests module usually 
contains an assertion library and a module that abstracts the high level functionality of the module under test.

For an example look at the relationship between [alarm.js](https://github.com/mozilla-b2g/gaia/blob/38456b0b9ee903e597d2a2fd949c10fd673e1993/apps/clock/test/marionette/lib/alarm.js) and [alarm_panel_test.js](https://github.com/mozilla-b2g/gaia/blob/38456b0b9ee903e597d2a2fd949c10fd673e1993/apps/clock/test/marionette/alarm_panel_test.js)
`alarm.js` implements a `toggleClock()` method which handles the complexity of using the marionette client to select and tap dom elements.

```JavaScript
Alarm.prototype.toggleClock = function() {
  var target;

  ['analog', 'digital'].forEach(function(clockType) {
    var el = this.el.alarm[clockType + 'Clock'];
    if (el.displayed()) {
      target = el;
    }
  }, this);

  if (!target) {
    throw new Error('Unable to toggle clock face: no clock is displayed.');
  }

  target.tap();
};
```

This makes the 'Clock interaction' test in `alarm_panel_test.js` much simpler and easier to understand.

```JavaScript
  test('Clock interaction', function() {
    assert(alarm.analogClockDisplayed, 'analog clock is displayed');
    assert(!alarm.digitalClockDisplayed, 'digital clock is not displayed');

    alarm.toggleClock();

    assert(
      !alarm.analogClockDisplayed,
      'analog clock is not displayed after toggle'
    );
    assert(
      alarm.digitalClockDisplayed,
      'digital clock is displayed after toggle'
    );
  });
```

### Test Setup

Marionette tests should start with a `marionette` function. This is just a simple wrapper for mocha's suite/describe blocks.
Dependencies can be required like any other node enviroment. Its worth noting that the `marionette` function has `client` and `plugin` properties
which can be used for additional functionality in tests.

For more information see the [marionette-js-runner](https://github.com/lightsofapollo/marionette-js-runner#marionette-suitedescribe-like-a-api) documentation.

Example:

```JavaScript
marionette('Alarm Panel', function() {
  var assert = require('./lib/assert');
  var Alarm = require('./lib/alarm');
  var client = marionette.client();
  var alarm;

  setup(function() {
    alarm = new Alarm(client);

    alarm.launch();
  });
  //...
```

### Troubleshooting

**Tests are hanging.** If the tests are failing because b2g is "hanging"
(either on the "Based on Mozilla Technology" splash screen or the "First time
use" screen), the following steps may resolve the issue (run each from the root
of the Gaia project):

- Remove the `b2g/` directory so the latest version is fetched:  
  `$ rm -rf b2g/`
- Remove and rebuild the "test" profile:  
  `$ rm -Rf profile-test && make PROFILE_FOLDER=profile-test`
