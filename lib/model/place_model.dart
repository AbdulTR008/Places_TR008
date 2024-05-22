import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Places {
  Places({required this.title, required this.images, required this.weather})
      : id = uuid.v4();

  final String title;
  final String weather;
  final String id;
  final File images;
}
