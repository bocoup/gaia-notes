## Integration Testing 

Gaia Integration tests use
[marionette](http://lightsofapollo.github.io/marionette_js_client/api-docs/)
to drive the B2G emulator and make assertions about the state of the application.

Marionette's [JavaScript
module](https://github.com/lightsofapollo/marionette_js_client) runs
in a Node enviroment and can be used to make issue commands to drive
the B2G emulator.

#### How to run the marionette integration tests:

```bash
make test-integration;
```
or 

```bash
./bin/gaia-marionette path/to/test-file;
# Example
./bin/gaia-marionette apps/clock/test/marionette/
```

