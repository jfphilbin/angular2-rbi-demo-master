import 'dart:async';

import 'package:grinder/grinder.dart';

Future main(List<String> args) async {
  await grind(args);
}

@Task('Format all directories')
void format() => DartFmt.format(existingSourceDirs);

@Task('Build demo to gh-pages')
Future buildDemo() async {
  await Pub.global.run('peanut');
}
