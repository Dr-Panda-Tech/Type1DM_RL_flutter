import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/twin_button.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';
import 'package:type1dm_rl_flutter/utils/widget/input_field.dart';

class InsulinUpdatePage extends StatefulWidget {
  const InsulinUpdatePage({super.key});

  @override
  _InsulinUpdatePageState createState() => _InsulinUpdatePageState();
}

class _InsulinUpdatePageState extends State<InsulinUpdatePage> {
  final ValueNotifier<DateTime?> dmDiagnosedDateNotifier =
  ValueNotifier<DateTime?>(null);
  final ValueNotifier<String?> rapidInsulinTypeNotifier =
  ValueNotifier<String?>(null);
  final ValueNotifier<String?> longActingInsulinTypeNotifier =
  ValueNotifier<String?>(null);
  final ValueNotifier<String?> longActingInsulinTimingNotifier =
  ValueNotifier<String?>(null);
  DateTime? dmDiagnosedDate;
  String? rapidInsulinType;
  String? longActingInsulinType;
  String? longActingInsulinTiming;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: CustomAppBar(titleText: '使用するインスリンの更新'),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            buildListSelectionWithIcon(
              context: context,
              label: "食前投与するインスリン",
              icon: Icons.flash_on,
              options: ['ノボラピッド', 'ヒューマリン'],
              onSelectionChanged: (value) {
                setState(() {
                  rapidInsulinType = value;
                });
              },
              selectedValueNotifier: rapidInsulinTypeNotifier,
            ),
            const SizedBox(height: 10),
            buildListSelectionWithIcon(
              context: context,
              label: "時効型インスリン",
              icon: Icons.timeline,
              options: ['未使用', 'グラルギン', 'トレシーバ'],
              onSelectionChanged: (value) {
                setState(() {
                  longActingInsulinType = value;
                  if (value == '未使用' || value == null) {
                    longActingInsulinTiming = null;
                  }
                });
              },
              selectedValueNotifier: longActingInsulinTypeNotifier,
            ),
            const SizedBox(height: 10),
            if (longActingInsulinType != null && longActingInsulinType != '未使用')
              buildListSelectionWithIcon(
                context: context,
                label: "時効型インスリンの使用タイミング",
                icon: Icons.timer,
                options: ['朝', '眠前'],
                onSelectionChanged: (value) {
                  setState(() {
                    longActingInsulinTiming = value;
                  });
                },
                selectedValueNotifier: longActingInsulinTimingNotifier,
              ),
            const SizedBox(height: 30),
            twinButton(
              leftOnPressed: () async {
                Navigator.pop(context);
              },
              leftText: '戻る',
              rightOnPressed: () async {
                if (rapidInsulinType != null && longActingInsulinType != null) {
                  if (longActingInsulinType != '未使用' &&
                      longActingInsulinTiming == null) {
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
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('全ての情報を入力してください。'),
                    ),
                  );
                }
              },
              rightText: '更新する',
            ),
          ],
        ),
      ),
    );
  }
}
