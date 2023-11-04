import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/profile_function.dart';

class UserProfileCard extends StatelessWidget {
  UserProfileCard({Key? key}) : super(key: key);

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
                // 2. FutureBuilderを使用して非同期に画像を取得し、取得が完了したら表示
                FutureBuilder<String?>(
                  future: profileFunc.getUserProfileImageUrl(user!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // データ読み込み中の場合、プレースホルダー画像を表示
                      return CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/dummy_user.png'),
                      );
                    } else if (snapshot.hasError) {
                      // エラーが発生した場合、エラーアイコンを表示
                      return CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.error, color: Colors.red),
                      );
                    } else {
                      // データの読み込みが完了した場合、取得した画像を表示
                      String? imageUrl = snapshot.data;
                      return CircleAvatar(
                        radius: 40,
                        backgroundImage: imageUrl != null
                            ? NetworkImage(imageUrl)
                            : AssetImage('assets/images/dummy_user.png') as ImageProvider,
                      );
                    }
                  },
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
                        'ユーザーID:',
                        style: kMiniCardTextStyle,
                      ), // ラベルのみの行
                      Text('${user.uid}', // 実際のユーザーIDの行
                          style: kMediumCardTextStyle,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      const Text(
                        'メールアドレス:',
                        style: kMiniCardTextStyle,
                      ), // ラベルのみの行ルのみの行
                      Text(
                          '${profileFunc.maskEmail(user.email)}', // 実際のメールアドレスの行
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
