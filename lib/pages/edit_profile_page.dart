import 'package:flutter/material.dart';

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
          TextFormField(),
          const SizedBox(height: 46),
          TextFormField(),
        ],
      ),
    );
  }
}
