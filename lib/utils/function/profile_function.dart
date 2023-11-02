import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileFunction {
  final BuildContext context;

  ProfileFunction(this.context);

  Future<String?> getUsername(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('user_detail')
        .doc(uid)
        .get();
    if (doc.exists) {
      return doc.data()?['username'] as String?;
    }
    return null;
  }

  Future<String?> getUserProfileImageUrl(String uid) async {
    try {
      String imageUrl = await FirebaseStorage.instance
          .ref('userImages/$uid.jpg') // 保存するときのパスを指定
          .getDownloadURL();
      return imageUrl;
    } catch (e) {
      return null; // 画像が存在しない場合はnullを返す
    }
  }

  Future<String?> getUserImageUrl(String uid) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    // .jpg拡張子でのファイル参照を試みる
    String jpgPath = 'userImages/$uid.jpg';
    Reference jpgRef = storage.ref().child(jpgPath);

    try {
      String downloadURL = await jpgRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error with .jpg: $e");
    }

    // .jpgでの取得が失敗した場合、.png拡張子でのファイル参照を試みる
    String pngPath = 'userImages/$uid.png';
    Reference pngRef = storage.ref().child(pngPath);

    try {
      String downloadURL = await pngRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print("Error with .png: $e");
      return null;
    }
  }

  Future<void> changeName() async {
    TextEditingController nameController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ユーザー名を変更'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "新しいユーザー名"),
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
                // TODO Firebaseに新しい名前を保存するロジックをここに追加
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> changeEmail() async {
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

  Future<void> changePassword() async {
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
              onPressed: () async {
                try {
                  // TODO google, apple sign in のときは？
                  await FirebaseAuth.instance.currentUser
                      ?.updatePassword(passwordController.text);
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

  String maskEmail(String? email) {
    if (email == null) return '';

    final parts = email.split('@');
    if (parts.length != 2) return email;

    final namePart = parts[0];
    final domainPart = parts[1];

    final maskedNamePart = namePart.length <= 4
        ? namePart
        : namePart.substring(0, 4) + '*' * (namePart.length - 4);

    return '$maskedNamePart@$domainPart';
  }

  Future<void> showQRCode(String qrImagePath) async {
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

  Future<void> logout() async {
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

  Future<void> deleteAccount() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }
}
