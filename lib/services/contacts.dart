library contacts_service;

import 'package:angular2/angular2.dart';
import 'package:uuid/uuid.dart';

final Uuid uuidGenerator = new Uuid();

@Injectable()
class Contacts {
  List<Contact> contacts = [];
  String currentFilter;

  int get length => contacts.length;

  final List<String> _types = ['family', 'friend', 'work'];

  void add(String last, String first, String phone,
      [String type, String uuid]) {
    if (uuid == null || uuid == '') uuid = uuidGenerator.v4();
    if (type == null || type == '') type = 'friend';
    contacts.add(new Contact(last, first, phone, type, uuid));
    sort();
  }

  void sort() {
    contacts.sort((a, b) {
      return (a.last + a.first).compareTo(b.last + b.first);
    });
  }

  void update(Contact c) {
    Contact old = find(c.uuid);
    int idx = contacts.indexOf(old);
    contacts[idx] = c;
    sort();
  }

  bool remove(Contact c) => contacts.remove(c);

  Contact find(String uuid) {
    for (Contact item in contacts) {
      if (item.uuid == uuid) return item;
    }
    return null;
  }

  List<Contact> filter(String type) {
    bool _filter(Contact c) => c.type == type;

    if (!_types.contains(type)) return contacts;
    return contacts.where(_filter).toList();
  }

  List<Contact> toJson() {
    return contacts;
  }
}

class Contact {
  String last, first, phone, type;
  final String uuid;

  Contact(this.last, this.first, this.phone, this.type, this.uuid);

  Map<String, String> toJson() => {
    'uuid': uuid,
    'last': last,
    'first': first,
    'phone': phone,
    'contactType': type
  };
}
