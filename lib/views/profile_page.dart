import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<void> _changeName() async {
    TextEditingController nameController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('名前を変更'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "新しい名前"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('変更'),
              onPressed: () {
                // Firebaseに新しい名前を保存するロジックをここに追加
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _changeEmail() async {
    TextEditingController emailController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('メールアドレスを変更'),
          content: TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "新しいメールアドレス"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('変更'),
              onPressed: () {
                // Firebaseに新しいメールアドレスを保存するロジックをここに追加
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _changePassword() async {
    TextEditingController passwordController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('パスワードを変更'),
          content: TextField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: "新しいパスワード"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('変更'),
              onPressed: () {
                // Firebaseに新しいパスワードを保存するロジックをここに追加
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    final context = this.context;
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/authPage');
  }

  Future<void> _deleteAccount() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('プロフィール')),
      body: ListView(
        children: [
          // ユーザー情報カード
          const Card(
            color: Color(0xFFBADCAD),
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFBADCAD),
                    backgroundImage: AssetImage('assets/images/dummy_user.png'),// ダミーのユーザーアイコン画像
                  ),
                  SizedBox(height: 16),
                  Text('ユーザー名', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('簡単な情報を表示'),
                ],
              ),
            ),
          ),
          // 設定やお問い合わせフォームへのリンクリスト
          ListTile(
            title: const Text('名前'),
            onTap: _changeName,
          ),
          ListTile(
            title: const Text('メールアドレス'),
            onTap: _changeEmail,
          ),
          ListTile(
            title: const Text('パスワードの変更'),
            onTap: _changePassword,
          ),
          SwitchListTile(
            title: const Text('通知'),
            value: true,
            onChanged: (bool value) {
              // 通知設定のロジックを追加
            },
          ),
          ListTile(
            title: const Text('ログアウト'),
            onTap: _logout,
          ),
          ListTile(
            title: const Text('アカウント削除'),
            onTap: _deleteAccount,
          ),
        ],
      ),
    );
  }
}
