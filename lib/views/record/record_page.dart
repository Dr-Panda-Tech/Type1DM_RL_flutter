import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/function/record_function.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';
import 'package:type1dm_rl_flutter/utils/widget/list_tile.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  String? mealCategory;
  TextEditingController glucoseController = TextEditingController();
  bool _isLoading = false;
  int? recommendationUnit;  // 変数名を変更

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customListTile(
              leadingIcon: Icons.bloodtype,
              titleText: '血液検査結果を入力する',
              onTapAction: () {
                Navigator.pushNamed(context, '/bloodTestPage');
              },
            ),
            customListTile(
              leadingIcon: Icons.medication_liquid,
              titleText: 'インスリンを変更する',
              onTapAction: () {
                Navigator.pushNamed(context, '/insulinSettingsPage');
              },
            ),
            DropdownButton<String>(
              value: mealCategory,
              hint: const Text(
                '食事のカテゴリーを選択',
                style: kLargeButtonTextStyle,
              ), // ヒントテキストのフォントサイズを変更
              onChanged: (String? newValue) {
                setState(() {
                  mealCategory = newValue;
                });
              },
              items: <String>['大', '中', '小']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: kLargeButtonTextStyle,
                  ), // アイテムのフォントサイズを変更
                );
              }).toList(),
              itemHeight: 60, // アイテムの高さを変更
            ),
            const SizedBox(height: 20),
            TextField(
              controller: glucoseController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '直前の血糖値',
                border: OutlineInputBorder(),
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly, // 数値のみを許可
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await Future.delayed(const Duration(seconds: 2));
                recommendationUnit = calculateRecommendation();  // 関数名を変更
                saveGlucoseInsulinToFirestore(
                  mealCategory: mealCategory,
                  glucose: glucoseController.text,
                  recommendationUnit: recommendationUnit,  // 変数名を変更
                );
                setState(() {
                  _isLoading = false;
                });
              },
              style: elevatedButtonStyle,
              child: const Text('単位数を計算する', style: kLargeButtonTextStyle,),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator(),  // ローディング中はアニメーションを表示
            if (recommendationUnit != null && !_isLoading)
              Text(
                '推奨単位数: $recommendationUnit単位',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),  // 計算後は推奨インスリン単位を表示
          ],
        ),
      ),
    );
  }
}
