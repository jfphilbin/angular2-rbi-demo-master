//TODO: copyright

library contact_list.components.contact_table;

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2_rbi/directives.dart';
import 'package:contact_list/services/contacts.dart';

@Component(
    selector: 'contact-table',
    inputs: const ['filter'],
    templateUrl: 'contact_table.html',
    directives: const [CORE_DIRECTIVES, MaterialButton])

class ContactList {
  static const Map<String, String> iconRepresentations = const {
    'friend': 'face',
    'work': 'work',
    'family': 'home'
  };
  final Contacts _data;
  final RouteParams _params;
  final Router _router;
  bool isLoaded false;
  String filter = '';
  List<Contact> contacts;

  ContactList._(this._data, this._params, this._router);

  factory ContactList(this._data, this._params, this._router) {
    if (!isLoaded) {

    }
    String filter = _params.get('filter');
    if (filter != null) contacts = _data.filter(filter);
    _data.currentFilter = filter;
  }

  String iconGlyph(Contact contact) {
    String type = contact.type;
    var icon = iconRepresentations[type];
    return (icon != null) ? icon : 'insert_emoticon';
  }

  String phoneDisplay(String aString) {
    if (aString.length != 10) {
      return aString;
    }
    String a = aString.substring(0, 3);
    String b = aString.substring(3, 6);
    String c = aString.substring(6, 10);
    return '($a) $b-$c';
  }

  void add(String last, String first, String phone) {
    _data.add(last, first, phone);
  }

  void edit(String uuid) {
    _router.navigate([
      'Edit',
      {'uuid': uuid}
    ]);
  }

  void delete(String uuid) {
    _router.navigate([
      {'uuid': uuid}
    ]);
  }
}
