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
                '次に糖尿病に関する情報を入力しましょう',
                style: kHeader2TextStyle,
              ),
            ),
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
            ),
            buildSelectFieldWithIcon(
              label: "速効型インスリン",
              icon: Icons.flash_on,
              options: ['ノボラピッド', 'ヒューマリン'],
              onValueChanged: (value) {
                setState(() {
                  rapidInsulinType = value;
                });
              },
            ),
            const SizedBox(height: 32),
            buildSelectFieldWithIcon(
              label: "時効型インスリン",
              icon: Icons.access_time,
              options: ['未使用', 'グラルギン', 'トレシーバ'],
              onValueChanged: (value) {
                setState(() {
                  longActingInsulinType = value;
                  if (value == '未使用' || value == null) {
                    longActingInsulinTiming = null;
                  }
                });
              },
            ),
            const SizedBox(height: 32),
            if (longActingInsulinType != null && longActingInsulinType != '未使用')
              buildSelectFieldWithIcon(
                label: "時効型インスリンの使用タイミング",
                icon: Icons.alarm,
                options: ['朝', '眠前'],
                onValueChanged: (value) {
                  setState(() {
                    longActingInsulinTiming = value;
                  });
                },
              ),
            const SizedBox(height: 32),
            twinButton(
              leftOnPressed: () async {
                Navigator.pop(context);
              },
              leftText: '戻る',
              rightOnPressed: () async {
                if (rapidInsulinType != null && longActingInsulinType != null) {
                  await saveInsulinTypeFirestore(
                    rapidInsulinType: rapidInsulinType!,
                    longActingInsulinType: longActingInsulinType!,
                    longActingInsulinTiming: longActingInsulinTiming,
                  );
                  Navigator.pushNamed(context, '/primaryCareSettingsPage');
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
