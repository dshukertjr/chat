import 'package:chat/models/chat.dart';
import 'package:chat/models/firestore_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String threadId;

  const ChatPage(
    this.threadId, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Chat>>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .where('threadId', isEqualTo: threadId)
                    .snapshots()
                    .map((snap) =>
                        snap.docs.map((doc) => Chat.fromSnap(doc)).toList()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  final chats = snapshot.data;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    itemBuilder: (_, index) {
                      final chat = chats[index];
                      return _ChatCell(chat);
                    },
                    itemCount: chats.length,
                  );
                }),
          ),
          Material(
            elevation: 10,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ).copyWith(bottom: MediaQuery.of(context).padding.bottom),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'メッセージを入力...',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('送信'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatCell extends StatelessWidget {
  const _ChatCell(
    this.chat, {
    Key key,
  }) : super(key: key);

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/user.png',
            width: 30,
            height: 30,
          ),
        ),
        const SizedBox(width: 11),
        Flexible(
          child: Material(
            borderRadius: BorderRadius.circular(8),
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                chat.text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 11),
        Text('12:12'),
      ],
    );
  }
}
