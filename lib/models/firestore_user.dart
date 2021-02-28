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

  FirestoreUser.fromMap(Map<String, dynamic> map)
      : uid = map['uid'] as String,
        name = map['name'] as String,
        userId = map['userId'] as String,
        profileImageUrl = map['profileImageUrl'] as String;

  Map<String, dynamic> toMap({bool isForChat}) {
    return {
      'uid': uid,
      'name': name,
      if (!isForChat != true) 'userId': userId,
      'profileImageUrl': profileImageUrl,
    };
  }
}
