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