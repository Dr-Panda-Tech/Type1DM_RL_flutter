import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ProfileFunction {
  final BuildContext context;

  ProfileFunction(this.context);

  void goBackToProfilePage(BuildContext context) {
    Navigator.pop(context);
  }

  Future<String?> getUsername(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('user_name')
        .doc(uid)
        .get();
    if (doc.exists) {
      return doc.data()?['username'] as String?;
    }
    return null;
  }

  Future<String?> getUserProfileImageUrl(String uid) async {
    // 利用可能な拡張子のリスト
    List<String> fileExtensions = ['.png', '.jpg', '.jpeg', '.JPEG', '.hex'];

    // Firebase Storageの参照を取得
    FirebaseStorage storage = FirebaseStorage.instance;

    // 利用可能な拡張子を順番に試して、画像が見つかるかチェック
    for (String extension in fileExtensions) {
      try {
        String imageUrl = await storage
            .ref('userImages/$uid$extension') // ユーザーIDと拡張子を使ってパスを指定
            .getDownloadURL();
        // 画像のURLが見つかったら、すぐに返す
        return imageUrl;
      } catch (e) {
        // 特定の拡張子の画像が存在しない場合は、キャッチして次の拡張子で試す
        continue;
      }
    }
    // どの拡張子にも一致する画像が見つからなかった場合はnullを返す
    return null;
  }

  Future<String?> getFacilityNameFromTypeAndId(String uid) async {
    // Firestoreから最新のtimestampを持つドキュメントを取得
    final querySnapshot = await FirebaseFirestore.instance
        .collection('primary_care')
        .doc(uid)
        .collection('content')
        .orderBy('timestamp', descending: true) // timestampで降順にソート
        .limit(1) // 最初の1つのドキュメントのみを取得
        .get();

    // ドキュメントがない場合はnullを返す
    if (querySnapshot.docs.isEmpty) return null;

    // 最新のドキュメントを取得
    final docSnapshot = querySnapshot.docs.first;

    String? facilityType = docSnapshot.data()['facility_type'] as String?;
    String? facilityId = docSnapshot.data()['facility_id'] as String?;

    // facilityTypeまたはfacilityIdがnullの場合はnullを返す
    if (facilityType == null || facilityId == null) return null;

    // 対応するJSONファイル名を決定
    String jsonFile = facilityType == '病院' ? 'assets/json/hospitalMaster.json' : 'assets/json/clinicMaster.json';

    // JSONファイルを読み込む
    String jsonString = await rootBundle.loadString(jsonFile);
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // facility_idに一致する施設名を探す
    String? facilityName;
    for (var prefecture in jsonMap.entries) {
      for (var city in prefecture.value.entries) {
        for (var facility in city.value) {
          if (facility['id'] == facilityId) {
            facilityName = facility['name'];
            break;
          }
        }
        if (facilityName != null) break;
      }
      if (facilityName != null) break;
    }
    return facilityName;
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
}
