import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/widget/input_field.dart';
import 'package:type1dm_rl_flutter/utils/button/single_register_button.dart';

class BloodTestInputPage extends StatefulWidget {
  @override
  _BloodTestInputPageState createState() => _BloodTestInputPageState();
}

class _BloodTestInputPageState extends State<BloodTestInputPage> {

  // 日付選択を行う部分
  DateTime? testDate;
  final ValueNotifier<DateTime?> testDateNotifier = ValueNotifier<DateTime?>(null);
  TextEditingController sodiumController = TextEditingController();
  TextEditingController potassiumController = TextEditingController();
  TextEditingController chlorideController = TextEditingController();
  TextEditingController eGFRController = TextEditingController();
  TextEditingController creController = TextEditingController();
  TextEditingController bunController = TextEditingController();
  TextEditingController uaController = TextEditingController();
  TextEditingController hba1cController = TextEditingController();
  TextEditingController hbController = TextEditingController();
  TextEditingController wbcController = TextEditingController();
  TextEditingController pltController = TextEditingController();
  TextEditingController gluController = TextEditingController();
  TextEditingController cPeptideController = TextEditingController();

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
          padding: EdgeInsets.all(36.0),
          child: Form(
            child: Column(
              children: [
                // 日付選択
                Padding(
                  padding: const EdgeInsets.only(right: 120.0),
                  child: buildYearDateFieldWithIcon(
                    context: context,
                    label: "検査日",
                    icon: Icons.calendar_today,
                    initialDate: DateTime(1980, 1, 1),
                    onDateChanged: (value) {
                      setState(() {
                        testDate = value;
                      });
                    },
                    selectedDateNotifier: testDateNotifier, // ここでValueNotifierを渡します
                  ),
                ),
                Divider(),
                // 各種検査項目
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: sodiumController,
                  label: "Na+",
                  maxWidth: 200,
                  placeholder: "例：140.3",
                  unit: "mEq/L",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: potassiumController,
                  label: "K+",
                  maxWidth: 200,
                  placeholder: "例：4.3",
                  unit: "mEq/L",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: chlorideController,
                  label: "Cl-",
                  maxWidth: 200,
                  placeholder: "例：100.3",
                  unit: "mEq/L",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: hbController,
                  label: "Hb",
                  maxWidth: 200,
                  placeholder: "例：10.3",
                  unit: "g/dL",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: pltController,
                  label: "Platelet",
                  maxWidth: 200,
                  placeholder: "例：214.0",
                  unit: "×10³/μL",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: wbcController,
                  label: "WBC",
                  maxWidth: 200,
                  placeholder: "例：9400",
                  unit: "μL",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: uaController,
                  label: "UA",
                  maxWidth: 200,
                  placeholder: "例：4.3",
                  unit: "mg/dL",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: bunController,
                  label: "BUN",
                  maxWidth: 200,
                  placeholder: "例：12.2",
                  unit: "mg/dL",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: creController,
                  label: "CRE",
                  maxWidth: 200,
                  placeholder: "例：0.2",
                  unit: "mg/dL",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: eGFRController,
                  label: "eFGR",
                  maxWidth: 200,
                  placeholder: "例：84.3",
                  unit: "mL/min/1.73㎡",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: gluController,
                  label: "Glucose",
                  maxWidth: 200,
                  placeholder: "例：84.0",
                  unit: "mg/dl",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: hba1cController,
                  label: "HbA1c",
                  maxWidth: 200,
                  placeholder: "例：6.3",
                  unit: "%",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 5.0,),
                CustomFormWidgets.buildNumberField(
                  context: context,
                  controller: potassiumController,
                  label: "C-peptide",
                  maxWidth: 200,
                  placeholder: "例：1.2",
                  unit: "ng/mL",
                  allowDecimal: true, // <- 小数点を許可します。
                  decimal: 1, // 小数点以下2桁までを許容
                ),
                const SizedBox(height: 10),
                Divider(),
                const SizedBox(height: 10),
                singleRegisterButton(
                  onPressed: () {
                    // 提出処理
                  },
                  text: '登録する',
                  icon: Icons.add,
                  color: ColorConstants.pandaBlack,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
