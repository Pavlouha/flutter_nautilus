import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {


  group('Integration tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    /*test('Captain test', () async {

      print("Login as Captain");
      await driver.runUnsynchronized(() async {
        await driver.tap(find.text("Log in"));
        await driver.waitFor(find.text('Authorization'));

        await driver.tap(find.byValueKey('Username'));
        await driver.enterText('pavlouh');

        await driver.tap(find.byValueKey('Password'));
        await driver.enterText('qwerty');

        await driver.tap(find.text("Next"));
        await driver.tap(find.text("Next"));

        print('Now "Auths"');
        await driver.waitFor(find.text('Auths'));

        print('Now "Users"');
        await driver.tap(find.text("Users"));
        await driver.waitFor(find.text('Name/Role/Login'));

        print('Now "Orders"');
        await driver.tap(find.text("Orders"));
        await driver.waitFor(find.text('Order#/Client/Consp'));

      });
    });*/

    /*test('Conspirator test', () async {

      print("Login as Conspirator");
      await driver.runUnsynchronized(() async {
        await driver.tap(find.text("Log in"));
        await driver.waitFor(find.text('Authorization'));

        await driver.tap(find.byValueKey('Username'));
        await driver.enterText('conspirator');

        await driver.tap(find.byValueKey('Password'));
        await driver.enterText('qwerty');

        await driver.tap(find.text("Next"));
        await driver.tap(find.text("Next"));

        print('Now "Orders"');
        await driver.waitFor(find.text('Order#/Client/State'));

        print('Now "Clients"');
        await driver.tap(find.text("Clients"));

        await driver.waitFor(find.text('Customers'));

      });
    });*/

    test('Storekeeper test', () async {

      print("Login as Storekeeper");
      await driver.runUnsynchronized(() async {
        await driver.tap(find.text("Log in"));
        await driver.waitFor(find.text('Authorization'));

        await driver.tap(find.byValueKey('Username'));
        await driver.enterText('storekeeper');

        await driver.tap(find.byValueKey('Password'));
        await driver.enterText('qwerty');

        await driver.tap(find.text("Next"));
        await driver.tap(find.text("Next"));

        print('Now "Orders"');
        await driver.waitFor(find.text('Order#/Client/User'));

        print('Now "Guns"');
        await driver.tap(find.text("Guns"));

        await driver.waitFor(find.text('Gun#/Code/Price'));

      });
    });

    /*test('Gunsmith test', () async {

      print("Login as Gunsmith");
      await driver.runUnsynchronized(() async {
        await driver.tap(find.text("Log in"));
        await driver.waitFor(find.text('Authorization'));

        await driver.tap(find.byValueKey('Username'));
        await driver.enterText('gunsmith');

        await driver.tap(find.byValueKey('Password'));
        await driver.enterText('qwerty');

        await driver.tap(find.text("Next"));
        await driver.tap(find.text("Next"));

        print('Now "Guns"');
        await driver.waitFor(find.text('VendorCode/Price'));

        print('Now "InOrder"');
        await driver.tap(find.text("Guns"));

        await driver.waitFor(find.text('#/Gun/Quantity'));

      });
    });*/
});
}