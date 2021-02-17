import 'package:chat/models/firestore_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
              children: [
                TextFormField(
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
                ..._searchResults(),
              ],
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
