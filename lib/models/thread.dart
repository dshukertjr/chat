import 'package:flutter/foundation.dart';

class Thread {
  final String id;
  final String text;
  final DateTime updatedAt;
  final List<String> uids;

  Thread({
    @required this.id,
    @required this.text,
    @required this.updatedAt,
    @required this.uids,
  });
}
