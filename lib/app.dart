import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2_rbi/directives.dart';
import 'package:contact_list/services/contacts.dart';

import 'components/contact_list.dart';
import 'components/delete_confirm.dart';
import 'components/edit_contact.dart';
import 'components/json_export.dart';

// found these in angular2_rbi/src/material_layout.dart
// needed to shut the nav drawer after clicking a link
const String isDrawerOpen = 'is-visible';
const String mdlObfuscator = 'mdl-layout__obfuscator';
const String mdlDrawer = 'mdl-layout__drawer';

@Component(
    selector: 'app',
    templateUrl: 'app.html',
    directives: const [
      ContactList,
      MaterialButton,
      MaterialMenu,
      MaterialLayout,
      ROUTER_DIRECTIVES,
      MaterialSpinner,
      NgIf
    ])

@RouteConfig(const [
  const Route(path: '/:filter', component: ContactList, name: 'Default'),
  const Route(path: '/json', component: JsonExport, name: 'Json'),
  const Route(path: '/delete:uuid', component: DeleteConfirm, name: 'Delete'),
  const Route(path: '/edit:uuid', component: EditContact, name: 'Edit')
])

class App {
  bool examplesLoaded = false;
  bool loading = false;

  final Router _router;
  final Contacts _contacts;

  App(this._router, this._contacts) {
    importJson();
  }

  void toggleDrawer() {
    // make the drawer go away when a link is clicked.
    // These elements are dynamically generated for MDL. The constants are
    // found in in angular2_rbi/src/material_layout.dart.
    Element drawer = querySelector('.$mdlDrawer');
    drawer.classes.toggle(isDrawerOpen);
    Element obfuscator = querySelector('.$mdlObfuscator');
    obfuscator.classes.toggle(isDrawerOpen);
  }

  void exportJson() {
    _router.navigate(['Json']);
  }

  Future importJson([String inputFile = 'contacts.json']) async {
    loading = true;
    String data = await HttpRequest.getString(inputFile);

    // just a bit of delay so the spinner shows
    new Timer(new Duration(seconds: 5), () {
      List<Map> exampleData = JSON.decode(data);
      examplesLoaded = true;

      for (Map item in exampleData) {
        _contacts.add(item['last'], item['first'], item['phone'],
            item['contactType'], item['uuid']);
      }
      //refresh page with the new data
      _router.navigate([
        'Default',
        {'filter': _contacts.currentFilter}
      ]);
      loading = false;
    });
  }
}
