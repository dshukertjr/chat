import 'package:flutter/foundation.dart';

class FirestoreUser {
  final String uid;
  final String name;
  final String userId;
  final String profileImageUrl;

  FirestoreUser({
    @required this.uid,
    @required this.name,
    @required this.userId,
    this.profileImageUrl,
  });
}
