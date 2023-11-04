import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

int calculateRecommendation() {  // 関数名を変更
  // ここではダミーデータを返します
  return 5;
}

Future<void> saveGlucoseInsulinToFirebase({
  required String? userId,
  required String? mealCategory,
  required String glucose,
  required int? recommendationUnit,
}) async {
  if (userId == null) {
    print("User is not logged in.");
    return;
  }

  // 現在の時刻をISO 8601形式の文字列として取得
  String currentTime = DateTime.now().toIso8601String();

  final data = {
    'userId': userId,
    'timestamp': currentTime,
    'mealCategory': mealCategory,
    'glucose': glucose,
    'recommendation': recommendationUnit,
  };

  await FirebaseFirestore.instance
      .collection('insulin')
      .doc(userId)
      .set(data);
}
