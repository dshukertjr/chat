import 'package:chat/models/chat.dart';
import 'package:chat/models/firestore_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

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
                    .orderBy('createdAt')
                    .snapshots()
                    .map((snap) =>
                        snap.docs.map((doc) => Chat.fromSnap(doc)).toList()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('エラーが発生しました'),
                    );
                  }
                  final chats = snapshot.data;
                  return ListView.builder(
                    reverse: true,
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
          _ChatBar(threadId: threadId),
        ],
      ),
    );
  }
}

class _ChatBar extends StatefulWidget {
  const _ChatBar({
    Key key,
    @required this.threadId,
  }) : super(key: key);

  final String threadId;

  @override
  __ChatBarState createState() => __ChatBarState();
}

class __ChatBarState extends State<_ChatBar> {
  final _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
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
                controller: _chatController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'メッセージを入力...',
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final text = _chatController.text;
                if (text.isEmpty) {
                  return;
                }
                final firestore = FirebaseFirestore.instance;
                final user = FirebaseAuth.instance.currentUser;
                final snap = await firestore
                    .collection('users')
                    .doc(user.uid)
                    .get(const GetOptions(source: Source.cache));
                final firestoreUser = FirestoreUser.fromMap(snap.data());
                final chatMap = {
                  'text': text,
                  'threadId': widget.threadId,
                  'createdAt': FieldValue.serverTimestamp(),
                  'user': firestoreUser.toMap(isForChat: true),
                };
                await firestore.collection('chats').add(chatMap);
                _chatController.clear();
              },
              child: const Text('送信'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
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
              elevation: 2,
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
          Text(timeago.format(chat.createdAt, locale: 'en_short')),
        ],
      ),
    );
  }
}
