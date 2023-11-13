import 'dart:ui';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<Uint8List?> generateQRCode(String data) async {
  // データからQRコードを生成する関数 //
  final qrValidationResult = QrValidator.validate(
    data: data,
    version: QrVersions.auto,
    errorCorrectionLevel: QrErrorCorrectLevel.L,
  );

  if (qrValidationResult.status == QrValidationStatus.valid) {
    final qrCode = qrValidationResult.qrCode;
    final painter = QrPainter.withQr(
      qr: qrCode!,
      gapless: false,
      embeddedImageStyle: null,
      embeddedImage: null,
    );
    final picData = await painter.toImageData(2048, format: ImageByteFormat.png);
    return picData?.buffer.asUint8List();
  } else {
    throw Exception('Unable to generate QR Code, invalid input data');
  }
}

Future<void> uploadQRCode(Uint8List qrCode, String uid) async {
  // QRコードをStorageに保存する関数 //
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child('qrCodes/$uid.png');
  await ref.putData(qrCode);
}

Future<void> generateAndUploadQRCode() async {
  // generateQRCode,uploadQRCodeを一連の流れで利用する関数 //
  final user = await FirebaseAuth.instance.currentUser;
  if (user != null) {
    // ユーザーのUIDとメールアドレスを含むデータを生成
    String data = 'uid: ${user.uid}, email: ${user.email}';
    // QRコードを生成
    Uint8List? qrCode = await generateQRCode(data);
    if (qrCode != null) {
      // QRコードをFirebaseにアップロード
      await uploadQRCode(qrCode, user.uid);
    }
  } else {
    throw Exception('No User Sign In!');
  }
}