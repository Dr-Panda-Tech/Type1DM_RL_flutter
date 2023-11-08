import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/twin_button.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';
import 'package:type1dm_rl_flutter/utils/widget/input_field.dart';

class DemographicsMutableUpdatePage extends StatefulWidget {
  const DemographicsMutableUpdatePage({super.key});

  @override
  _DemographicsMutableUpdatePage createState() =>
      _DemographicsMutableUpdatePage();
}

class _DemographicsMutableUpdatePage extends State<DemographicsMutableUpdatePage> {
  TextEditingController userNameController = TextEditingController();
  final ValueNotifier<String?> selectedGenderNotifier =
  ValueNotifier<String?>(null);
  String? gender;
  DateTime? birthDate;
  final ValueNotifier<DateTime?> birthDateNotifier = ValueNotifier<DateTime?>(null);
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void dispose() {
    birthDateNotifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: CustomAppBar(titleText: '身長・体重の更新'),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, //画面外タップを検知するために必要
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0), // 余白を32.0に変更
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 40),
                CustomFormWidgets.buildNumberFieldWithIcon(
                  context: context,
                  controller: heightController,
                  label: "身長",
                  icon: Icons.height,
                  maxWidth: 160,
                  placeholder: "例：160.5",
                  unit: "cm",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下1桁までを許容
                ),
                const SizedBox(height: 10),
                CustomFormWidgets.buildNumberFieldWithIcon(
                  context: context,
                  controller: weightController,
                  label: "体重",
                  icon: Icons.scale,
                  maxWidth: 160,
                  placeholder: "例：60.5",
                  unit: "kg",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 30),
                twinButton(
                  leftOnPressed: () async {
                    Navigator.pop(context);
                  },
                  leftText: '戻る',
                  rightOnPressed: () async {
                    if (heightController.text.isNotEmpty &&
                        weightController.text.isNotEmpty) {
                      await saveHeightWeightFirestore(
                        height: double.parse(heightController.text),
                        weight: double.parse(weightController.text),
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
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
