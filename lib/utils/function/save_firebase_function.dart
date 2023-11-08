import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveDemographicsImmutableFirestore({
  required String? gender,
  required DateTime? birthDate,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  String currentTime = DateTime.now().toIso8601String();

  final userData = {
    'uid' : uid,
    'timestamp': currentTime,
    'gender': gender,
    'birth_date': birthDate,
  };

  await FirebaseFirestore.instance
      .collection('demographics')
      .doc(uid)
      .set(userData);
}

Future<void> saveUsernameFirestore({
  required String username,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  String currentTime = DateTime.now().toIso8601String();

  final userData = {
    'uid' : uid,
    'timestamp': currentTime,
    'username': username,
  };

  await FirebaseFirestore.instance
      .collection('user_name')
      .doc(uid)
      .set(userData);
}

Future<void> saveHeightWeightFirestore({
  required double height,
  required double weight,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  String currentTime = DateTime.now().toIso8601String();

  final userData = {
    'uid' : uid,
    'timestamp': currentTime,
    'height': height,
    'weight': weight,
  };

  await FirebaseFirestore.instance
      .collection('physique')
      .doc(uid)
      .set(userData);
}

Future<void> savePrimaryCareFirestore({
  required String selectedType, // 施設の一意のIDだけを引数として受け取る
  required String selectedFacilityId, // 施設の一意のIDだけを引数として受け取る
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String currentTime = DateTime.now().toIso8601String();

  final data = {
    'uid' : uid,
    'timestamp': currentTime,
    'facility_type': selectedType, // IDだけを保存
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
    'meal_category': mealCategory,
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
      'active_status_time': currentTime,
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
    'active_status_time': currentTime,
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

Future<void> saveBloodTestFirestore({
  required DateTime? testDate,
   double? sodium,
   double? potassium,
   double? chloride,
   double? hb,
   double? plt,
   double? wbc,
   double? ua,
   double? bun,
   double? cre,
   double? egfr,
   double? glucose,
   double? hba1c,
   double? cpeptide,

}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final data = {
    'uid' : uid,
    'test_date': testDate?.toIso8601String(), // DateTimeを文字列に変換します。
    'sodium': sodium,
    'potassium': potassium,
    'chloride': chloride,
    'hb': hb,
    'plt': plt,
    'wbc': wbc,
    'ua': ua,
    'bun': bun,
    'cre': cre,
    'egfr': egfr,
    'glucose': glucose,
    'hba1c': hba1c,
    'cpeptide': cpeptide,
  };

  await FirebaseFirestore.instance
      .collection('blood_test')
      .doc(uid)
      .collection('content')
      .add(data);
}