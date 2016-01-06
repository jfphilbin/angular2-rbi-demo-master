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
    template: '''<div class="mdl-layout mdl-js-layout">
  <header class="mdl-layout__header">
    <div class="mdl-layout__header-row">
      <!-- Title -->
      <span class="mdl-layout-title">Contacts</span>
      <!-- Add spacer, to align navigation to the right -->
      <div class="mdl-layout-spacer"></div>
      <!-- Navigation -->
      <nav class="mdl-navigation">
        <a class="mdl-navigation__link" [routerLink]="['/Default', {'filter':''}]">All</a>
        <a class="mdl-navigation__link" [routerLink]="['/Default',{'filter':'family'}]">Family</a>
        <a class="mdl-navigation__link" [routerLink]="['/Default',{'filter':'friend'}]">Friends</a>
        <a class="mdl-navigation__link" [routerLink]="['/Default',{'filter':'work'}]">Work</a>
      </nav>
      <button
          class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon"
          id="hdrbtn">
        <i class="material-icons">more_vert</i>
      </button>
    </div>

  </header>
  <div class="mdl-layout__drawer">
    <span class="mdl-layout-title">Contacts</span>
    <nav class="mdl-navigation" (click)="toggleDrawer()">
      <a class="mdl-navigation__link" [routerLink]="['/Default', {'filter':''}]">All</a>
      <a class="mdl-navigation__link" [routerLink]="['/Default', {'filter':'family'}]">Family</a>
      <a class="mdl-navigation__link" [routerLink]="['/Default', {'filter':'friend'}]">Friends</a>
      <a class="mdl-navigation__link" [routerLink]="['/Default', {'filter':'work'}]">Work</a>
    </nav>
  </div>
  <ul class="mdl-menu mdl-menu--bottom-right mdl-js-menu mdl-js-ripple-effect" for="hdrbtn">
     <!--we use buttons here instead of <li> so disabled works.-->
     <button class="mdl-menu__item" [disabled]="examplesLoaded==true" href="#" (click)="importJson()">Load JSON</button>
     <button class="mdl-menu__item" href="#" (click)="exportJson()">JSON Export</button>
  </ul>
  <main class="mdl-layout__content">
    <div *ngIf="loading" class="spinner">
    <div class="mdl-spinner mdl-js-spinner is-active"></div>
    </div>
    <div class="page-content"><router-outlet></router-outlet></div>
  </main>
</div>
    ''',
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

  Future importJson([String imputFile = 'contacts.json']) async {
    loading = true;
    String data = await HttpRequest.getString(imputFile);

    // just a bit of delay so the spinner shows
    new Timer(new Duration(seconds: 5), () {
      List<Map> exampleData = JSON.decode(data);
      examplesLoaded = true;

      for (Map item in exampleData) {
        _contacts.addContact(item['last'], item['first'], item['phone'],
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
