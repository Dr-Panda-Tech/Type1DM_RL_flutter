import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageHandler {
  final BuildContext context;
  File? imageFile; // 画像ファイルを保存するためのプロパティ
  final ImagePicker _picker = ImagePicker();

  ImageHandler(this.context);

  Future<File?> pickAndSetImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
    }
    return imageFile;
  }

  Future<void> uploadCurrentImage() async {
    if (imageFile != null) {
      try {
        String extension = imageFile!.path.split('.').last;
        await FirebaseStorage.instance
            .ref('userImages/${DateTime.now().toIso8601String()}.$extension')
            .putFile(imageFile!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('画像が正常にアップロードされました'),
          ),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('画像のアップロードに失敗しました'),
          ),
        );
      }
    }
  }
}
