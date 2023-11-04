import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<StatefulWidget> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: CustomAppBar(titleText: 'お問い合わせ'),
        backgroundColor: ColorConstants.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 32.0),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'お名前',
                      style: kFormLabelTextStyle,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "お名前",
                      hintStyle: kFormColorTextStyle,
                      filled: true,
                      border: InputBorder.none,
                      fillColor: ColorConstants.fieldGrey,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: kFormLabelTextStyle,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      hintStyle: kFormColorTextStyle,
                      filled: true,
                      border: InputBorder.none,
                      fillColor: ColorConstants.fieldGrey,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'お問合せ内容',
                      style: kFormLabelTextStyle,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    controller: _messageController,
                    keyboardType: TextInputType.text,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "お問い合わせ内容",
                      hintStyle: kFormColorTextStyle,
                      filled: true,
                      border: InputBorder.none,
                      fillColor: ColorConstants.fieldGrey,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  color: ColorConstants.fieldGrey,
                  child: Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        // ダイアログを表示
                        bool shouldSend = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('確認'),
                                    content: Text(
                                      '送信しますか？',
                                      style: kColorTextStyle,
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'キャンセル',
                                          style: kColorTextStyle,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(false); // ダイアログを閉じ、送信しない
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'OK',
                                          style: kColorTextStyle,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(true); // ダイアログを閉じ、送信する
                                        },
                                      ),
                                    ],
                                  );
                                }) ??
                            false; // ダイアログの外部をタップして閉じた場合などにはfalseを返す

                        // 「OK」が選択された場合に送信
                        if (shouldSend) {
                          saveContactFormFirestore(
                            name: _nameController.text,
                            email: _emailController.text,
                            message: _messageController.text,
                          );

                          // フォームの内容をクリア
                          _nameController.clear();
                          _emailController.clear();
                          _messageController.clear();
                        }
                      },
                      child: const Text(
                        "送信",
                        style: kSendFormTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
