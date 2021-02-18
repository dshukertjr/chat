import 'package:chat/models/firestore_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'chat_page.dart';

class IdSearchPage extends StatefulWidget {
  @override
  _IdSearchPageState createState() => _IdSearchPageState();
}

class _IdSearchPageState extends State<IdSearchPage> {
  final _searchQueryController = TextEditingController();
  bool _loading = false;
  bool _haveSearched = false;
  FirestoreUser _searchedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー検索'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 44),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextFormField(
                    onEditingComplete: _search,
                    textInputAction: TextInputAction.search,
                    controller: _searchQueryController,
                    decoration: InputDecoration(
                      labelText: 'ユーザーIDで検索',
                      suffixIcon: IconButton(
                        icon: const Icon(FeatherIcons.search),
                        onPressed: _search,
                      ),
                    ),
                  ),
                ),
                ..._searchResults(),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _searchedUser == null
            ? null
            : () async {
                final uid = FirebaseAuth.instance.currentUser.uid;
                final uidList = [uid, _searchedUser.uid];
                uidList.sort();
                final threadId = uidList.join();
                await FirebaseFirestore.instance
                    .collection('threads')
                    .doc(threadId)
                    .set({
                  'uids': FieldValue.arrayUnion(uidList),
                }, SetOptions(merge: true));
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => ChatPage(threadId),
                  ),
                );
              },
        icon: const Icon(FeatherIcons.messageCircle),
        label: const Text('メッセージを送る'),
      ),
    );
  }

  Future<void> _search() async {
    setState(() {
      _loading = true;
    });
    final searchQuery = _searchQueryController.text;
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: searchQuery)
        .limit(1)
        .get();
    if (snap.docs.isNotEmpty) {
      _searchedUser = FirestoreUser.fromMap(snap.docs.first.data());
    } else {
      _searchedUser = null;
    }
    setState(() {
      _loading = false;
      _haveSearched = true;
    });
  }

  List<Widget> _searchResults() {
    if (!_haveSearched) {
      return [];
    } else if (_searchedUser == null) {
      return [
        const Text('ユーザーが見つかりませんでした'),
      ];
    } else {
      return [
        const SizedBox(height: 64),
        Center(
          child: ClipOval(
            child: SizedBox(
                width: 150,
                height: 150,
                child: Image.asset("assets/images/user.png")),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          _searchedUser.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 17),
        ),
      ];
    }
  }
}
