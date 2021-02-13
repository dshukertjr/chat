import 'package:chat/pages/edit_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void initState() {
    _route();
    super.initState();
  }

  Future<void> _route() async {
    final auth = FirebaseAuth.instance;

    // ログインしているかどうかのチェック
    final user = auth.currentUser;
    if (user == null) {
      await auth.signInAnonymously();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => EditProfilePage()),
      );
      return;
    }

    // プロフィールが登録済みかどうかのチェック
  }
}
