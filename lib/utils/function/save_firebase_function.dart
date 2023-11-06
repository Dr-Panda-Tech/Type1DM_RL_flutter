import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveDemographicsToFirestore({
  required String username,
  required String? gender,
  required DateTime? birthDate,
  required double height,
  required double weight,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  String currentTime = DateTime.now().toIso8601String();

  final userData = {
    'uid' : uid,
    'timestamp': currentTime,
    'username': username,
    'gender': gender,
    'birthDate': birthDate,
    'height': height,
    'weight': weight,
  };

  await FirebaseFirestore.instance
      .collection('demographics')
      .doc(uid)
      .set(userData);
}

Future<void> savePrimaryCareFirestore({
  required String selectedFacilityId, // 施設の一意のIDだけを引数として受け取る
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String currentTime = DateTime.now().toIso8601String();

  final data = {
    'uid' : uid,
    'timestamp': currentTime,
    'facility_id': selectedFacilityId, // IDだけを保存
  };

  await FirebaseFirestore.instance
      .collection('primary_care')
      .doc(uid)
      .collection('content')
      .add(data);
}


Future<void> saveInsulinTypeFirestore({
  required String rapidInsulinType,
  required String longActingInsulinType,
  required String? longActingInsulinTiming,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String currentTime = DateTime.now().toIso8601String();

  final data = {
    'uid' : uid,
    'timestamp': currentTime,
    'rapid_type': rapidInsulinType,
    'long_type': longActingInsulinType,
    'long_timing': longActingInsulinTiming,
  };

  await FirebaseFirestore.instance
      .collection('insulin_type')
      .doc(uid)
      .collection('content')
      .add(data);
}

Future<void> saveGlucoseInsulinToFirestore({
  required String? mealCategory,
  required String glucose,
  required int? recommendationUnit,
}) async {

  final uid = FirebaseAuth.instance.currentUser!.uid;
  String currentTime = DateTime.now().toIso8601String();

  final data = {
    'uid' : uid,
    'timestamp': currentTime,
    'mealCategory': mealCategory,
    'glucose': glucose,
    'recommendation': recommendationUnit,
  };

  await FirebaseFirestore.instance
      .collection('glucose_insulin')
      .doc(uid)
      .collection('content')
      .add(data);
}

Future<void> saveContactFormFirestore({
  required String name,
  required String email,
  required String message,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String currentTime = DateTime.now().toIso8601String();

  final data = {
    'timestamp': currentTime,
    'name': name,
    'email': email,
    'message': message,
  };

  // ユーザーごとのサブコレクションに新しいドキュメントを追加
  await FirebaseFirestore.instance
      .collection('contact_form')
      .doc(uid)
      .collection('content')
      .add(data);
}

Future<void> saveActivateUserFirestore() async {
  try {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    String currentTime = DateTime.now().toIso8601String();

    final user_status = {
      'uid' : uid,
      'activeStatusOn': currentTime,
      'isActive': true,
    };
    await FirebaseFirestore.instance
        .collection('user_status')
        .doc(uid)
        .set(user_status);
  } catch (e) {
    print("Error saving user status: $e");
    throw e;
  }
}

Future<void> saveDeactivateUserFirestore({
  required String? reason,
  required String? details,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String currentTime = DateTime.now().toIso8601String();

  final data = {
    'uid' : uid,
    'timestamp': currentTime,
    'reason': reason,
    'details': details,
  };
  // 退会情報をFirestoreに保存
  await FirebaseFirestore.instance
      .collection('withdrawal')
      .doc(uid)
      .set(data);

  final user_status = {
    'uid' : uid,
    'activeStatusOn': currentTime,
    'isActive': false,
  };

// ドキュメントの存在をチェック
  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user_status').doc(uid).get();

  if (userDoc.exists) {
    // ドキュメントが存在する場合、updateを使用してデータを上書き
    await userDoc.reference.update(user_status);
  } else {
    // ドキュメントが存在しない場合、setを使用して新しいドキュメントを作成
    await userDoc.reference.set(user_status);
  }
}