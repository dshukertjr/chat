import 'package:chat/models/firestore_user.dart';
import 'package:flutter/foundation.dart';

class Chat {
  final String threadId;
  final FirestoreUser user;
  final String text;
  final DateTime createdAt;

  Chat({
    @required this.threadId,
    @required this.user,
    @required this.text,
    @required this.createdAt,
  });
}
