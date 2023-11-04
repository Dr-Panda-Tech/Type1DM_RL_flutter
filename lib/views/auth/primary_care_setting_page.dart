import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/twin_button.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';
import 'package:type1dm_rl_flutter/utils/widget/input_field.dart';

class PrimaryCareSettingsPage extends StatefulWidget {
  final bool fromSettings;

  PrimaryCareSettingsPage({required this.fromSettings});

  @override
  _PrimaryCareSettingsPageState createState() =>
      _PrimaryCareSettingsPageState();
}

class _PrimaryCareSettingsPageState extends State<PrimaryCareSettingsPage> {
  Map<String, dynamic>? clinicMaster;
  Map<String, dynamic>? hospitalMaster;

  String? selectedType = '病院';
  String? selectedPrefecture;
  String? selectedDistrict;
  String? selectedFacility;
  String? selectedFacilityId;  // これを追加

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  void loadJsonData() async {
    String clinicData =
        await rootBundle.loadString('assets/json/clinicMaster.json');
    String hospitalData =
        await rootBundle.loadString('assets/json/hospitalMaster.json');

    setState(() {
      clinicMaster = json.decode(clinicData);
      hospitalMaster = json.decode(hospitalData);
    });
  }

  Map<String, dynamic> getMasterData() {
    if (selectedType == "クリニック") {
      return clinicMaster!;
    } else {
      return hospitalMaster!;
    }
  }

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
                '最後にかかりつけに関する情報を入力しましょう',
                style: kHeader2TextStyle,
              ),
            ),
            buildSelectFieldWithIcon(
              label: "クリニックか病院かを選択",
              icon: Icons.location_on,
              options: ['クリニック', '病院'],
              onValueChanged: (value) {
                setState(() {
                  selectedType = value;
                  selectedPrefecture = null;
                  selectedDistrict = null;
                  selectedFacility = null;
                });
              },
              selectedValue: selectedType,
            ),
            if (selectedType != null) ...[
              buildSelectFieldWithIcon(
                label: "都道府県を選択",
                icon: Icons.location_city,
                options: getMasterData().keys.toList(),
                onValueChanged: (value) {
                  setState(() {
                    selectedPrefecture = value;
                    selectedDistrict = null;
                    selectedFacility = null;
                  });
                },
                selectedValue: selectedPrefecture,
              ),
              if (selectedPrefecture != null) ...[
                buildSelectFieldWithIcon(
                  label: "地区を選択",
                  icon: Icons.map,
                  options:getMasterData()[selectedPrefecture!].keys.toList(),
                  onValueChanged: (value) {
                    setState(() {
                      selectedDistrict = value;
                      selectedFacility = null;
                    });
                  },
                  selectedValue: selectedDistrict,
                ),
                if (selectedDistrict != null) ...[
                  buildSelectFieldWithIcon(
                    label: "施設名を選択",
                    icon: Icons.local_hospital,
                    options: getMasterData()[selectedPrefecture!]
                            [selectedDistrict!]
                        .map((e) => e["name"] as String)
                        .toList(),
                    onValueChanged: (value) {
                      var selectedFacility = getMasterData()[selectedPrefecture!][selectedDistrict!].firstWhere(
                              (e) => e["name"] == value
                      );
                      setState(() {
                        selectedFacility = value;
                        selectedFacilityId = selectedFacility["id"];  // ここでIDを設定
                      });
                    },
                    selectedValue: selectedFacility,
                  ),
                ],
              ],
            ],
            const SizedBox(height: 32),
            twinButton(
              leftOnPressed: () async {
                Navigator.pop(context);
              },
              leftText: '戻る',
              rightOnPressed: () async {
                if (selectedFacilityId != null) {  // selectedFacilityIdを確認
                  await savePrimaryCareFirestore(
                    selectedFacilityId: selectedFacilityId!,  // IDを関数に渡す
                  );
                  Navigator.pushReplacementNamed(context, '/authPage');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('全ての情報を入力してください。'),
                    ),
                  );
                }
              },
              rightText: '登録完了',
            ),
          ],
        ),
      ),
    );
  }
}
