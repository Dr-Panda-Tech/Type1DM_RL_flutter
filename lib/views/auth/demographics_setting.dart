import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/twin_button.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';
import 'package:type1dm_rl_flutter/utils/widget/input_field.dart';

class DemographicsSettingPage extends StatefulWidget {
  const DemographicsSettingPage({super.key});

  @override
  _DemographicsSettingPageState createState() =>
      _DemographicsSettingPageState();
}

class _DemographicsSettingPageState extends State<DemographicsSettingPage> {
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, //画面外タップを検知するために必要
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0), // 余白を32.0に変更
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'まずは基本的な情報を入力しましょう',
                    style: kHeader2TextStyle,
                  ),
                ),
                const SizedBox(height: 40),
                buildTextFieldWithIcon(
                    controller: userNameController,
                    label: "ユーザー名（表示名）",
                    icon: Icons.person,
                    placeholder: "例：Dr.パンダ"),
                const SizedBox(height: 10),
                buildListSelectionWithIcon(
                  context: context,
                  label: "性別を選択",
                  icon: Icons.male,
                  options: ["男性", "女性"],
                  onSelectionChanged: (value) {
                    setState(() {
                      // この例では、選択したオプションを単に表示します。
                      gender = value;
                    });
                  },
                  selectedValueNotifier: selectedGenderNotifier,
                ),
                const SizedBox(height: 10),
                buildYearDateFieldWithIcon(
                  context: context,
                  label: "生年月日",
                  icon: Icons.calendar_today,
                  initialDate: DateTime(1980, 1, 1),
                  onDateChanged: (value) {
                    setState(() {
                      birthDate = value;
                    });
                  },
                  selectedDateNotifier: birthDateNotifier, // ここでValueNotifierを渡します
                ),
                const SizedBox(height: 10),
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
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, '/authPage');
                  },
                  leftText: '戻る',
                  rightOnPressed: () async {
                    if (userNameController.text.isNotEmpty &&
                        gender != null &&
                        birthDate != null &&
                        heightController.text.isNotEmpty &&
                        weightController.text.isNotEmpty) {
                      await saveDemographicsToFirestore(
                        username: userNameController.text,
                        gender: gender,
                        birthDate: birthDate,
                        height: double.parse(heightController.text),
                        weight: double.parse(weightController.text),
                      );
                      Navigator.pushNamed(context, '/insulinSettingsPage');
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
        ),
      ),
    );
  }
}
