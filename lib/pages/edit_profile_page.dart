import 'package:chat/pages/threads_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _userIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登録'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
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
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'ユーザー名',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'ユーザー名を入力してください';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 46),
                  TextFormField(
                    controller: _userIdController,
                    decoration: const InputDecoration(
                      labelText: 'ユーザーID',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'ユーザーIDを入力してください';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final isValid = _formKey.currentState.validate();
          if (!isValid) {
            return;
          }
          setState(() {
            _isLoading = true;
          });
          final name = _nameController.text;
          final userId = _userIdController.text;
          //TODO Firestoreに値を保存
          final user = FirebaseAuth.instance.currentUser;
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(
            {
              'name': name,
              'userId': userId,
              'uid': user.uid,
            },
            SetOptions(merge: true),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ThreadsPage(),
            ),
          );
        },
        icon: const Icon(FeatherIcons.save),
        label: const Text('保存する'),
      ),
    );
  }
}
