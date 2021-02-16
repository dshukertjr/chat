import 'package:chat/models/firestore_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class IdSearchPage extends StatefulWidget {
  @override
  _IdSearchPageState createState() => _IdSearchPageState();
}

class _IdSearchPageState extends State<IdSearchPage> {
  final _searchQueryController = TextEditingController();
  bool _haveSearched = false;
  FirestoreUser _searchedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー検索'),
      ),
      body: ListView(
        children: [
          TextFormField(
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

  Future<void> _search() {}

  List<Widget> _searchResults() {
    if (!_haveSearched) {
      return [];
    } else if (_searchedUser == null) {
      return [
        const Text('ユーザーが見つかりませんでした'),
      ];
    } else {
      return [
        Center(
          child: ClipOval(
            child: Image.asset('assets/images/user.png'),
          ),
        ),
        const SizedBox(height: 24),
        Text(_searchedUser.name)
      ];
    }
  }
}
