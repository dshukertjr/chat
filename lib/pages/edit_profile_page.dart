import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登録'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 46,
          horizontal: 60,
        ),
        children: [
          Center(
            child: ClipOval(
              child: Image.asset(
                'assets/images/user.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
          const SizedBox(height: 46),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ユーザー名',
            ),
          ),
          const SizedBox(height: 46),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ユーザーID',
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(FeatherIcons.save),
        label: const Text('保存する'),
      ),
    );
  }
}
