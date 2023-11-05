import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class WithdrawalPage extends StatefulWidget {
  @override
  _WithdrawalPageState createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  String? reason; // 退会理由を保存するための変数
  final detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: CustomAppBar(titleText: '退会ページ'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '退会すると、すべてのデータが削除されます。\nよろしいですか？',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text('退会理由：'),
              DropdownButton<String>(
                value: reason,
                items: <String>[
                  '理由1',
                  '理由2',
                  '理由3',
                  'その他',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: kColorTextStyle,
                    ),
                  );
                }).toList(),
                hint: Text("理由を選択してください"),
                onChanged: (value) {
                  setState(() {
                    reason = value!;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text('詳細：'),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: detailsController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '詳細を入力してください。',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // 確認ダイアログを表示
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('確認'),
                        content: Text('本当に退会しますか？'),
                        actions: [
                          TextButton(
                            child: Text('キャンセル'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('退会'),
                            onPressed: () async {
                              await saveDeactivateUserFirestore(
                                reason: reason,
                                details: detailsController.text,
                              );
                              // ここでその他の退会処理を行うことができます。
                              Navigator.pushReplacementNamed(context, '/authPage');
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('退会する'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
