import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/profile_function.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final profileFunc = ProfileFunction(context);
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  top: 40, // ボタンの位置を調整するための余白を追加
                  left: 20,
                ),
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back), // 戻るボタンのアイコン
                  onPressed: () {
                    profileFunc.goBackToProfilePage(context); // 前のページに戻る
                  },
                ),
              ),
              Text(
                'プロフィールの編集',
                style: kHeader1TextStyle,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '名前',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'メールアドレス',
                ),
              ),
              // 以下、他の基本情報の入力欄も追加可能
            ],
          ),
        ),
      ),
    );
  }
}
