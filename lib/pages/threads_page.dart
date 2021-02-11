import 'package:chat/models/thread.dart';
import 'package:chat/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ThreadsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
        actions: [
          IconButton(
            icon: const Icon(FeatherIcons.user),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        itemBuilder: (_, index) {
          final thread = Thread(
            id: 'aaa',
            text: 'じゃあまた時間になったら連絡するね',
            updatedAt: DateTime.now(),
            uids: ['aaa', 'bbb'],
          );
          return _ThreadCell(thread: thread);
        },
        separatorBuilder: (_, __) {
          return const Divider();
        },
        itemCount: 1,
      ),
    );
  }
}

class _ThreadCell extends StatelessWidget {
  const _ThreadCell({
    Key key,
    @required this.thread,
  }) : super(key: key);

  final Thread thread;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/user.png',
            width: 70,
            height: 70,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flutter太郎',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                ),
              ),
              Text(
                thread.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
