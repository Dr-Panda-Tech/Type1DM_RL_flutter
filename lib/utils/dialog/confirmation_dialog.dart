// import 'package:flutter/material.dart';
// import 'package:type1dm_rl_flutter/constants.dart';
// import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';
//
// Future<void> showConfirmationDialog(
//     BuildContext context,
//     String? selectedType,
//     String? selectedFacilityId,
//     ) async {
//   if (selectedFacilityId != null) {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('確認'),
//           content: Text(
//             'この情報で登録しますか？',
//             style: kColorTextStyle,
//           ),
//           actions: [
//             TextButton(
//               child: Text(
//                 'キャンセル',
//                 style: kColorTextStyle,
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('登録する', style: kColorTextStyle),
//               onPressed: () async {
//                 // ダイアログを閉じる
//                 Navigator.of(context, rootNavigator: true).pop();
//                 // ローディングプロセスを開始
//                 if (!mounted) return;
//                 setState(() => isLoading = true);
//                 // 非同期操作を実行
//                 await savePrimaryCareFirestore(
//                     selectedType: selectedType!,
//                     selectedFacilityId: selectedFacilityId!
//                 );
//                 // ウィジェットがまだマウントされているかをチェック
//                 if (!mounted) return;
//                 // ウィジェットがまだマウントされていれば新しいルートにナビゲート
//                 Navigator.of(context, rootNavigator: true).pushReplacementNamed('/rootPage');
//                 // ローディングプロセスを停止
//                 setState(() => isLoading = false);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('全ての情報を入力してください。'),
//       ),
//     );
//   }
// }