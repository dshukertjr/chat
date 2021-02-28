import 'package:chat/models/firestore_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Chat.fromSnap(DocumentSnapshot snap)
      : threadId = snap.data()['threadId'] as String,
        user = FirestoreUser.fromMap(Map<String, dynamic>.from(
            snap.data()['user'] as Map<dynamic, dynamic>)),
        text = snap.data()['text'] as String,
        createdAt = (snap.data()['createdAt'] as Timestamp)?.toDate();
}
