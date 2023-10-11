import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  String? mealCategory;
  TextEditingController glucoseController = TextEditingController();
  bool _isLoading = false;  // ロードアニメーションの表示フラグ
  String? _recommendation;

  Future<void> _saveData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // 現在のユーザーのUIDを取得
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print("User is not logged in.");
      return;
    }

    // 現在の時刻をISO 8601形式の文字列として取得
    String currentTime = DateTime.now().toIso8601String();

    return users
        .add({
      'userId': userId, // ユーザーIDを追加
      'mealCategory': mealCategory,
      'glucose': glucoseController.text,
      'timestamp': currentTime,
      'recommendation': _recommendation, // 推奨単位数を追加
    })
        .then((value) => print("Data Added"))
        .catchError((error) => print("Failed to add data: $error"));
  }



  String _getRecommendation() {
    // ここではダミーデータを返します
    return "5単位";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('メイン画面')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: mealCategory,
              hint: const Text(
                '食事のカテゴリーを選択',
                style: kLargeButtonTextStyle,
              ), // ヒントテキストのフォントサイズを変更
              onChanged: (String? newValue) {
                setState(() {
                  mealCategory = newValue;
                });
              },
              items: <String>['大', '中', '小']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: kLargeButtonTextStyle,
                  ), // アイテムのフォントサイズを変更
                );
              }).toList(),
              itemHeight: 60, // アイテムの高さを変更
            ),
            const SizedBox(height: 20),
            TextField(
              controller: glucoseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '直前の血糖値',
                border: OutlineInputBorder(),
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly, // 数値のみを許可
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await Future.delayed(const Duration(seconds: 2));  // ダミーの遅延
                _recommendation = _getRecommendation();
                _saveData();
                setState(() {
                  _isLoading = false;
                });
              },
              child: const Text('単位数を計算する', style: kLargeButtonTextStyle,),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator(),  // ローディング中はアニメーションを表示
            if (_recommendation != null && !_isLoading)
              Text(
                '推奨単位数: $_recommendation',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),  // 計算後は推奨インスリン単位を表示
          ],
        ),
      ),
    );
  }
}
