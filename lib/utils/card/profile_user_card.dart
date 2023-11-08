import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/profile_function.dart';
import 'package:type1dm_rl_flutter/utils/function/image_handler_function.dart';

class UserProfileCard extends StatefulWidget {
  UserProfileCard({super.key});

  @override
  _UserProfileCardState createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  XFile? _image;
  void _handleImageSelection(ImageSource source) async {
    final pickedImage = await pickImage(context, source);
    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final profileFunc = ProfileFunction(context);
    return Card(
      color: ColorConstants.pandaGreen,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => showImageSourceActionSheet(context, _handleImageSelection),
                  child: FutureBuilder<String?>(
                    future: profileFunc.getUserProfileImageUrl(user!.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<String?> snapshot) {
                      Widget displayedImage;
                      if (_image != null) {
                        // 選択した画像があればそれを表示
                        displayedImage = CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(File(_image!.path)),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        // データ読み込み中はデフォルト画像を表示
                        displayedImage = CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/images/dummy_user.png'),
                        );
                      } else if (snapshot.hasError || snapshot.data == null) {
                        // エラーがあるか、データがnullの場合はエラーアイコンを表示
                        displayedImage = CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage('assets/images/dummy_user.png'),
                        );
                      } else {
                        // データがある場合はFirebaseから取得した画像を表示
                        displayedImage = CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(snapshot.data!),
                        );
                      }
                      return displayedImage;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ユーザー名:',
                        style: kMiniCardTextStyle,
                      ), // ラベルのみの行
                      FutureBuilder<String?>(
                        future: profileFunc.getUsername(user.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            String? username = snapshot.data;
                            return Text(username ?? 'Unknown',
                                style: kLargeButtonTextStyle,
                                overflow: TextOverflow.ellipsis);
                          }
                          return CircularProgressIndicator(); // データの取得中
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'メールアドレス:',
                        style: kMiniCardTextStyle,
                      ), // ラベルのみの行ルのみの行
                      Text(
                          '${profileFunc.maskEmail(user.email)}', // 実際のメールアドレスの行
                          style: kMediumCardTextStyle,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      const Text(
                        'かかりつけ:',
                        style: kMiniCardTextStyle,
                      ), // ラベルのみの行ルのみの行
                      Text(
                          '${profileFunc.getFacilityNameFromTypeAndId(user.uid)}', // 実際のメールアドレスの行
                          style: kMediumCardTextStyle,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.qr_code),
                      onPressed: () =>
                          profileFunc.showQRCode('assets/images/dummy_qr.jpg'),
                    ),
                    const Text('QRコード'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.mail_outline),
                      onPressed: profileFunc.changeEmail,
                    ),
                    const Text('メールアドレス')
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.lock_outline),
                      onPressed: profileFunc.changePassword,
                    ),
                    const Text('パスワード')
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
