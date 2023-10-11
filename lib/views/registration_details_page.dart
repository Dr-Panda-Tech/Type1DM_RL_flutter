import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class RegistrationDetailsPage extends StatefulWidget {
  const RegistrationDetailsPage({super.key});

  @override
  _RegistrationDetailsPageState createState() => _RegistrationDetailsPageState();
}

class _RegistrationDetailsPageState extends State<RegistrationDetailsPage> {
  String? gender;
  DateTime? birthDate;
  DateTime? diabetesYear;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('詳細情報の登録')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          DropdownButton<String>(
            hint: const Text('性別を選択'),
            value: gender,
            onChanged: (String? value) {
              setState(() {
                gender = value;
              });
            },
            items: <String>['男性', '女性'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: Text(birthDate == null
                ? '生年月日を選択'
                : birthDate!.toLocal().toString().split(' ')[0]),
            trailing:  const Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (selectedDate != null) {
                setState(() {
                  birthDate = selectedDate;
                });
              }
            },
          ),
          ListTile(
            title: Text(diabetesYear == null
                ? '1型糖尿病発症年を選択'
                : diabetesYear!.toLocal().toString().split(' ')[0]),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (selectedDate != null) {
                setState(() {
                  diabetesYear = selectedDate;
                });
              }
            },
          ),
          const SizedBox(height: 20),
          TextField(
            controller: heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '身長',
              hintText: 'cm',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '体重',
              hintText: 'kg',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: jobController,
            decoration: const InputDecoration(
              labelText: '職業',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: elevatedButtonStyle,
            onPressed: () {
              if (gender != null &&
                  birthDate != null &&
                  diabetesYear != null &&
                  heightController.text.isNotEmpty &&
                  weightController.text.isNotEmpty &&
                  jobController.text.isNotEmpty) {
                // TODO: Firebaseに情報を保存するロジックを追加
                Navigator.pushNamed(context, '/insulinSettingsPage');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('全ての情報を入力してください。')));
              }
            },
            child: const Text('次へ'),
          ),
        ],
      ),
    );
  }
}
