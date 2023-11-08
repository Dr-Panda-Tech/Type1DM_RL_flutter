import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/widget/input_field.dart';

class BloodTestInputPage extends StatefulWidget {
  @override
  _BloodTestInputPageState createState() => _BloodTestInputPageState();
}

class _BloodTestInputPageState extends State<BloodTestInputPage> {

  // 日付選択を行う部分
  DateTime? testDate;
  final ValueNotifier<DateTime?> testDateNotifier = ValueNotifier<DateTime?>(null);

// 血液検査項目の入力フィールドを作成する関数
  Widget _buildTextFormField(String label,
      {String? placeholder, bool isOptional = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          suffixText: isOptional ? 'Optional' : null,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (isOptional) {
            return null; // 省略可能なフィールドは検証しない
          }
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          // ここに数値の検証ロジックを追加できます
          return null;
        },
      ),
    );
  }

// UIの全体構成
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor ,
      appBar: CustomAppBar(titleText: '血液検査結果の入力'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                // 日付選択
                buildYearDateFieldWithIcon(
                  context: context,
                  label: "生年月日",
                  icon: Icons.calendar_today,
                  initialDate: DateTime(1980, 1, 1),
                  onDateChanged: (value) {
                    setState(() {
                      testDate = value;
                    });
                  },
                  selectedDateNotifier: testDateNotifier, // ここでValueNotifierを渡します
                ),
                Divider(),
                // 各種検査項目
                _buildTextFormField('Sodium (Na)'),
                _buildTextFormField('Potassium (K)'),
                _buildTextFormField('Potassium (Cl)'),
                _buildTextFormField('Potassium (WBC)'),
                _buildTextFormField('Potassium (Hb)'),
                _buildTextFormField('Potassium (PLT)'),
                _buildTextFormField('Potassium (HbA1c)'),
                _buildTextFormField('Potassium (BUN)'),
                _buildTextFormField('Potassium (CRE)'),
                _buildTextFormField('Potassium (UA)'),
                _buildTextFormField('Potassium (eGFR)'),
                ElevatedButton(
                  onPressed: () {
                    // 提出処理
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
