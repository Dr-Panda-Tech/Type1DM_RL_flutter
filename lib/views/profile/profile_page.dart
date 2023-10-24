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

  Future<void> _showQRCode(String qrImagePath) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('あなたのQRコード'),
          content: Image(
            image: AssetImage(qrImagePath),
            width: 200.0,
            height: 200.0,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('閉じる'),
              onPressed: () {
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
              onPressed: () async {
                // Firebaseのメールアドレスを更新する
                try {
                  await FirebaseAuth.instance.currentUser
                      ?.updateEmail(emailController.text);
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e);
                  // エラーメッセージを表示するなどのエラーハンドリングを追加
                }
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
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ログアウトの確認'),
          content: const Text('本当にログアウトしますか？'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('ログアウト'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/authPage');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  String maskEmail(String? email) {
    if (email == null) return '';

    final parts = email.split('@');
    if (parts.length != 2) return email; // メールアドレスの形式が正しくない場合、そのまま返す

    final namePart = parts[0];
    final domainPart = parts[1];

    final maskedNamePart = namePart.length <= 4
        ? namePart
        : namePart.substring(0, 4) + '*' * (namePart.length - 4);

    return '$maskedNamePart@$domainPart';
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('プロフィール')),
      body: ListView(
        children: [
          Card(
            color: ColorConstants.pandaGreen,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xFFBADCAD),
                        backgroundImage:
                            AssetImage('assets/images/dummy_user.png'),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('ユーザー名: ダミーユーザー',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('ユーザーID: ${user?.uid}',
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis),
                            Text('メールアドレス: ${maskEmail(user?.email)}',
                                style: const TextStyle(
                                    fontSize: 14)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.qr_code),
                            onPressed: () => _showQRCode('assets/images/dummy_qr.jpg'),
                          ),
                          const Text('QRコード'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.mail_outline),
                            onPressed: _changeEmail,
                          ),
                          const Text('メールアドレス')
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.lock_outline),
                            onPressed: _changePassword,
                          ),
                          const Text('パスワード')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 設定やお問い合わせフォームへのリンクリスト
          ListTile(
            title: const Text('ユーザー情報の変更'),
            onTap: _changeName,
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
