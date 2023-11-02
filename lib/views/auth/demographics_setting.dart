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
  String? gender;
  DateTime? birthDate;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: SingleChildScrollView(
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
              buildSelectFieldWithIcon(
                label: "性別を選択",
                icon: Icons.arrow_drop_down,
                options: ["男性", "女性"],
                selectedValue: gender,
                onValueChanged: (value) {
                  setState(() {
                    // この例では、選択したオプションを単に表示します。
                    gender = value;
                  });
                },
              ),
              const SizedBox(height: 5),
              buildDateFieldWithIcon(
                context: context,
                label: "生年月日",
                icon: Icons.calendar_today,
                initialDate: DateTime(1980, 1, 1),
                onDateChanged: (value) {
                  setState(() {
                    birthDate = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              buildNumberFieldWithIcon(
                controller: heightController,
                label: "身長",
                icon: Icons.height,
                maxWidth: 160,
                placeholder: "例：160.5",
                unit: "cm",
                allowDecimal: true, // <- 小数点を許可します。
              ),
              const SizedBox(height: 15),
              buildNumberFieldWithIcon(
                controller: weightController,
                label: "体重",
                icon: Icons.scale,
                maxWidth: 160,
                placeholder: "例：60.5",
                unit: "kg",
                allowDecimal: true, // <- 小数点を許可します。
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
                      height: int.parse(heightController.text),
                      weight: double.parse(weightController.text),
                    );
                    Navigator.pushNamed(context, '/UserImageSettingPage');
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
    );
  }
}
