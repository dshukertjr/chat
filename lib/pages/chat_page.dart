import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String threadId;

  const ChatPage(
    this.threadId, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              itemBuilder: (_, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/user.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Flexible(
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 4,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '時間になったら連絡します。時間になったら連絡します。',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Text('12:12'),
                  ],
                );
              },
              itemCount: 1,
            ),
          ),
          Material(
            elevation: 10,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ).copyWith(bottom: MediaQuery.of(context).padding.bottom),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'メッセージを入力...',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('送信'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
