import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class BloodTestInputPage extends StatefulWidget {
  @override
  _BloodTestInputPageState createState() => _BloodTestInputPageState();
}

class _BloodTestInputPageState extends State<BloodTestInputPage> {

// 日付選択を行う部分
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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
      appBar: CustomAppBar(titleText: '血液検査結果の入力'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                // 日付選択
                ListTile(
                  title: Text(
                      "Sample Collection Date: ${selectedDate.toLocal()}"
                          .split(' ')[0]),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
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
