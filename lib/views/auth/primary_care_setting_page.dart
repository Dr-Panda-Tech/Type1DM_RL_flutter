import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/utils/button/twin_button.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';
import 'package:type1dm_rl_flutter/utils/widget/input_field.dart';

class PrimaryCareSettingsPage extends StatefulWidget {
  const PrimaryCareSettingsPage({super.key});

  @override
  _PrimaryCareSettingsPageState createState() =>
      _PrimaryCareSettingsPageState();
}

class _PrimaryCareSettingsPageState extends State<PrimaryCareSettingsPage> {
  bool isLoading = true; // 初期状態ではローディング中とみなします
  Map<String, dynamic>? clinicMaster;
  Map<String, dynamic>? hospitalMaster;

  final ValueNotifier<String?> selectedTypeNotifier =
      ValueNotifier<String?>(null);
  final ValueNotifier<String?> selectedPrefectureNotifier =
      ValueNotifier<String?>(null);
  final ValueNotifier<String?> selectedDistrictNotifier =
      ValueNotifier<String?>(null);
  final ValueNotifier<String?> selectedFacilityNotifier =
      ValueNotifier<String?>(null);

  String? selectedType = '病院';
  String? selectedPrefecture;
  String? selectedDistrict;
  String? selectedFacility;
  String? selectedFacilityId; // これを追加

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
      isLoading = false; // データがロードされたので、ローディングを終了する
    });
  }

  Map<String, dynamic> getMasterData() {
    if (selectedType == "クリニック") {
      return clinicMaster!;
    } else {
      return hospitalMaster!;
    }
  }

  Future<void> _showConfirmationDialog() async {
    if (selectedFacilityId != null) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('確認'),
            content: Text(
              'この情報で登録しますか？',
              style: kColorTextStyle,
            ),
            actions: [
              TextButton(
                child: Text(
                  'キャンセル',
                  style: kColorTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('登録する', style: kColorTextStyle),
                onPressed: () {
                  // ダイアログを閉じる
                  Navigator.of(context, rootNavigator: true).pop();
                  // 登録処理を開始
                  _register();
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('全ての情報を入力してください。'),
        ),
      );
    }
  }

  void _register() async {
    if (selectedFacilityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('施設が選択されていません。'),
        ),
      );
      return;
    }
    try {
      if (!mounted) return;
      setState(() => isLoading = true);

      await savePrimaryCareFirestore(
        selectedType: selectedType!,
        selectedFacilityId: selectedFacilityId!,
      );

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pushReplacementNamed('/rootPage');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('登録に失敗しました。エラー: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // ローディングインジケータを表示
        ),
      );
    }
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
            buildListSelectionWithIcon(
              context: context,
              label: "クリニックか病院かを選択",
              icon: Icons.location_on,
              options: ['病院', 'クリニック'],
              onSelectionChanged: (value) {
                setState(() {
                  selectedType = value;
                  selectedPrefecture = null;
                  selectedDistrict = null;
                  selectedFacility = null;
                });
              },
              selectedValueNotifier: selectedTypeNotifier,
            ),
            if (selectedType != null) ...[
              buildListSelectionWithIcon(
                context: context,
                label: "都道府県を選択",
                icon: Icons.location_city,
                options: getMasterData().keys.toList(),
                onSelectionChanged: (value) {
                  setState(() {
                    selectedPrefecture = value;
                    selectedDistrict = null;
                    selectedFacility = null;
                  });
                },
                selectedValueNotifier: selectedPrefectureNotifier,
              ),
              if (selectedPrefecture != null) ...[
                buildListSelectionWithIcon(
                  context: context,
                  label: "地区を選択",
                  icon: Icons.map,
                  options: getMasterData()[selectedPrefecture!].keys.toList(),
                  onSelectionChanged: (value) {
                    setState(() {
                      selectedDistrict = value;
                      selectedFacility = null;
                    });
                  },
                  selectedValueNotifier: selectedDistrictNotifier,
                ),
                if (selectedDistrict != null) ...[
                  buildListSelectionWithIcon(
                    context: context,
                    label: "施設名を選択",
                    icon: Icons.local_hospital,
                    options: getMasterData()[selectedPrefecture!]
                            [selectedDistrict!]
                        .map<String>((e) => e["name"] as String)
                        .toList(),
                    onSelectionChanged: (value) {
                      var facilityData = getMasterData()[selectedPrefecture!]
                              [selectedDistrict!]
                          .firstWhere((e) => e["name"] == value);
                      setState(() {
                        selectedFacility = value; // 選択された施設の名前を保存
                        selectedFacilityId = facilityData["id"]; // ここでIDを設定
                      });
                    },
                    selectedValueNotifier: selectedFacilityNotifier,
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
              rightOnPressed: _showConfirmationDialog,
              rightText: '登録完了',
            ),
          ],
        ),
      ),
    );
  }
}
