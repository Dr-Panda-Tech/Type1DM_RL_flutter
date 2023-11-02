import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/twin_button.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';

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

  String? selectedType;
  String? selectedPrefecture;
  String? selectedDistrict;
  String? selectedHospital;

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
            Expanded(
              child: ListView(
                children: [
                  DropdownButton<String>(
                    value: selectedType,
                    items: ['クリニック', '病院'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                        selectedPrefecture = null;
                        selectedDistrict = null;
                        selectedHospital = null;
                      });
                    },
                    hint: Text('クリニックか病院を選択'),
                  ),
                  if (selectedType != null && (selectedType == 'クリニック' ? clinicMaster != null : hospitalMaster != null)) ...[
                    DropdownButton<String>(
                      value: selectedPrefecture,
                      items: (selectedType == 'クリニック' ? clinicMaster! : hospitalMaster!).keys.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPrefecture = value;
                          selectedDistrict = null;
                          selectedHospital = null;
                        });
                      },
                      hint: Text('都道府県を選択'),
                    ),
                    if (selectedPrefecture != null) ...[
                      DropdownButton<String>(
                        value: selectedDistrict,
                        items: (selectedType == 'クリニック' ? clinicMaster![selectedPrefecture!] : hospitalMaster![selectedPrefecture!]).keys.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value;
                            selectedHospital = null;
                          });
                        },
                        hint: Text('地区を選択'),
                      ),
                      if (selectedDistrict != null) ...[
                        DropdownButton<String>(
                          value: selectedHospital,
                          items: (selectedType == 'クリニック' ? clinicMaster![selectedPrefecture!][selectedDistrict!] : hospitalMaster![selectedPrefecture!][selectedDistrict!])
                              .map((e) => e as Map<String, dynamic>)
                              .map((Map<String, dynamic> hospitalData) {
                            return DropdownMenuItem<String>(
                              value: hospitalData["name"],
                              child: Text(hospitalData["name"]),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedHospital = value;
                            });
                          },
                          hint: Text('病院/クリニックを選択'),
                        ),
                      ],
                    ],
                  ],
                ],
              ),
            ),
            const SizedBox(height: 32),
            twinButton(
              leftOnPressed: () async {
                Navigator.pop(context);
              },
              leftText: '戻る',
              rightOnPressed: () async {
                if (selectedType != null && selectedPrefecture != null && selectedDistrict != null && selectedHospital != null) {
                  await savePrimaryCareFirestore(
                    selectedType: selectedType!,
                    selectedPrefecture: selectedPrefecture!,
                    selectedDistrict: selectedDistrict!,
                    selectedHospital: selectedHospital!,
                  );
                  Navigator.pushReplacementNamed(context, '/authPage');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('全ての情報を入力してください。'),)
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
