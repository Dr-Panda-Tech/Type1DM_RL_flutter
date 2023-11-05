import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/twin_button.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';
import 'package:type1dm_rl_flutter/utils/widget/input_field.dart';

class InsulinSettingsPage extends StatefulWidget {
  final bool fromSettings;

  InsulinSettingsPage({this.fromSettings = false});

  @override
  _InsulinSettingsPageState createState() => _InsulinSettingsPageState();
}

class _InsulinSettingsPageState extends State<InsulinSettingsPage> {
  final ValueNotifier<DateTime> dmDiagnosedDateNotifier =
      ValueNotifier<DateTime>(
    DateTime(1980, 1, 1),
  );
  DateTime? dmDiagnosedDate;
  String? rapidInsulinType;
  String? longActingInsulinType;
  String? longActingInsulinTiming;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.center,
              child: Text(
                '次に糖尿病に関する情報です',
                style: kHeader2TextStyle,
              ),
            ),
            const SizedBox(height: 40),
            buildDateFieldWithIcon(
              context: context,
              label: "1型糖尿病と診断された年",
              icon: Icons.calendar_today,
              initialDate: DateTime(1980, 1, 1),
              onDateChanged: (value) {
                setState(() {
                  dmDiagnosedDate = value;
                });
              },
              selectedDateNotifier: dmDiagnosedDateNotifier,
            ),
            const SizedBox(height: 10),
            buildSelectFieldWithIcon(
              label: "食前投与するインスリン",
              icon: Icons.flash_on,
              options: ['ノボラピッド', 'ヒューマリン'],
              selectedValue: rapidInsulinType,
              onValueChanged: (value) {
                setState(() {
                  rapidInsulinType = value;
                });
              },
            ),
            const SizedBox(height: 10),
            buildSelectFieldWithIcon(
              label: "時効型インスリン",
              icon: Icons.access_time,
              options: ['未使用', 'グラルギン', 'トレシーバ'],
              selectedValue: longActingInsulinType,
              onValueChanged: (value) {
                setState(() {
                  longActingInsulinType = value;
                  if (value == '未使用' || value == null) {
                    longActingInsulinTiming = null;
                  }
                });
              },
            ),
            const SizedBox(height: 10),
            if (longActingInsulinType != null && longActingInsulinType != '未使用')
              buildSelectFieldWithIcon(
                label: "時効型インスリンの使用タイミング",
                icon: Icons.alarm,
                options: ['朝', '眠前'],
                selectedValue: longActingInsulinTiming,
                onValueChanged: (value) {
                  setState(() {
                    longActingInsulinTiming = value;
                  });
                },
              ),
            const SizedBox(height: 30),
            twinButton(
              leftOnPressed: () async {
                Navigator.pop(context);
              },
              leftText: '戻る',
              rightOnPressed: () async {
                if (rapidInsulinType != null && longActingInsulinType != null) {
                  if (longActingInsulinType != '未使用' && longActingInsulinTiming == null) {
                    // 時効型インスリンが「未使用」以外で、timingが未設定の場合のエラー
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('時効型インスリンの使用タイミングを選択してください。'),
                      ),
                    );
                    return; // このポイントで関数の実行を停止
                  }
                  await saveInsulinTypeFirestore(
                    rapidInsulinType: rapidInsulinType!,
                    longActingInsulinType: longActingInsulinType!,
                    longActingInsulinTiming: longActingInsulinTiming,
                  );
                  if (widget.fromSettings) {
                    Navigator.pop(context);  // RecordPageに戻る
                  } else {
                    Navigator.pushNamed(context, '/primaryCareSettingsPage');
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('全ての情報を入力してください。'),
                    ),
                  );
                }
              },
              rightText: '次へ',
            ),
          ],
        ),
      ),
    );
  }
}
