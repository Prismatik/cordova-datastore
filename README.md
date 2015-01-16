This plugin informally depends on the [Cordova-SQLite](https://github.com/brodysoft/Cordova-SQLitePlugin) plugin being available.

It provides an interface to SQLite similar to the interface you would get with localStorage. This is intended as a relatively painless way to switch a key value store from localStorage to SQLite once localStorage's 5MB limit becomes an issue.

Usage:

```javascript
var ds = require('cordova-datastore')();
ds.init('test_store', function(err) {
  if (err) throw err;

  ds.setItem('someKey', 'someValue', function(err) {
    if (err) throw err;

    ds.getItem('someKey', function(err, value) {
      if (err) throw err;
      console.log(value);

      ds.removeItem('someKey', function(err) {
        if (err) throw err;

        ds.clear(function(err) {
          if (err) throw err;
        });
      });
    });
  });
});
```
