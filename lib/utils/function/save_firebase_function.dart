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
    'timestamp': currentTime,
    'hospitalId': selectedFacilityId, // IDだけを保存
  };

  await FirebaseFirestore.instance
      .collection('primary_care')
      .doc(uid)
      .set(data);
}


Future<void> saveInsulinTypeFirestore({
  required String rapidInsulinType,
  required String longActingInsulinType,
  required String? longActingInsulinTiming,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String currentTime = DateTime.now().toIso8601String();

  final data = {
    'timestamp': currentTime,
    'rapid_type': rapidInsulinType,
    'long_type': longActingInsulinType,
    'long_timing': longActingInsulinTiming,
  };

  await FirebaseFirestore.instance
      .collection('insulin_type')
      .doc(uid)
      .set(data);
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
      .collection('glucose_insulin')
      .doc(userId)
      .set(data);
}

Future<void> saveContactFormFirestore({
  required String name,
  required String email,
  required String? message,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference contacts = FirebaseFirestore.instance.collection('contact_form');

  return contacts.add({
    'uid': uid,
    'name': name,
    'email': email,
    'message': message,
    'timestamp': FieldValue.serverTimestamp(),
  }).then((value) {
    print("Contact Added");
  }).catchError((error) {
    print("Failed to add contact: $error");
  });
}

