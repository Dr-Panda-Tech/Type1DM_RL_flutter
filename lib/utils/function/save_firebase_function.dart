import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveDemographicsToFirestore({
  required String username,
  required String? gender,
  required DateTime? birthDate,
  required int height,
  required double weight,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

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
      .doc(user.uid)
      .set(userData);
}

Future<void> savePrimaryCareFirestore({
  required String selectedType,
  required String selectedPrefecture,
  required String selectedDistrict,
  required String selectedHospital,
}) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String currentTime = DateTime.now().toIso8601String();

  final data = {
    'timestamp': currentTime,
    'type': selectedType,
    'prefecture': selectedPrefecture,
    'district': selectedDistrict,
    'hospital': selectedHospital,
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