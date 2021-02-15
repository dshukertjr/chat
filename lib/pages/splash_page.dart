import 'package:chat/pages/edit_profile_page.dart';
import 'package:chat/pages/threads_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (!snap.exists) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => EditProfilePage()),
      );
      return;
    }

    // 全てのチェックを通過したらチャット一覧ページへ
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => ThreadsPage()),
    );
  }
}
