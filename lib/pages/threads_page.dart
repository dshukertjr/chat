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
                    Text('Flutter太郎'),
                    Text(
                      'じゃあまた明日になったら連絡するね！じゃあまた明日になったら連絡するね！',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (_, __) {
          return const Divider();
        },
        itemCount: 1,
      ),
    );
  }
}
