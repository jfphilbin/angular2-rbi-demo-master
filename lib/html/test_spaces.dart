//TODO: copyright

import 'package:contact_list/html/spaces.dart';

void main() {
  Spaces sp = new Spaces(2);
  print('"$sp"');
  sp + 2;
  print('"$sp"');
  sp - 2;
  print('"$sp"');
  print('"${sp(2)}"');
  print('"${sp(-2)}"');
}
