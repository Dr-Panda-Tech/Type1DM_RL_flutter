import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';

class InsulinSettingsPage extends StatefulWidget {
  final bool fromSettings;

  InsulinSettingsPage({this.fromSettings = false});

  @override
  _InsulinSettingsPageState createState() => _InsulinSettingsPageState();
}

class _InsulinSettingsPageState extends State<InsulinSettingsPage> {
  String? rapidInsulinType;
  String? longActingInsulinType;
  String? longActingInsulinTiming;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('インスリン設定')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSelectionTile(
              title: '即効型インスリン',
              value: rapidInsulinType,
              items: ['ノボラピッド', 'ヒューマリン'],
              onChanged: (newValue) {
                setState(() {
                  rapidInsulinType = newValue;
                });
              },
              icon: Icons.flash_on,
            ),
            const SizedBox(height: 32),
            _buildSelectionTile(
              title: '時効型インスリン',
              value: longActingInsulinType,
              items: ['未使用', 'グラルギン', 'トレシーバ'],
              onChanged: (newValue) {
                setState(() {
                  longActingInsulinType = newValue;
                  if (newValue == '未使用' || newValue == null) {
                    longActingInsulinTiming = null;
                  }
                });
              },
              icon: Icons.access_time,
            ),
            const SizedBox(height: 32),
            if (longActingInsulinType != null && longActingInsulinType != '未使用')
              _buildSelectionTile(
                title: '時効型インスリンの摂取タイミング',
                value: longActingInsulinTiming,
                items: ['朝', '眠前'],
                onChanged: (newValue) {
                  setState(() {
                    longActingInsulinTiming = newValue;
                  });
                },
                icon: Icons.alarm,
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (widget.fromSettings) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(context, '/loginPage');
                }
              },
              style: elevatedButtonStyle,
              child: const Text('登録完了'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionTile({
    required String title,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: ColorConstants.accentColor, size: 24),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ColorConstants.accentColor, width: 1.5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                hint: const Text('選択', style: TextStyle(color: Colors.grey, fontSize: 16)),
                onChanged: onChanged,
                icon: Icon(Icons.arrow_drop_down, color: ColorConstants.accentColor),
                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: const TextStyle(fontSize: 16, color: Colors.black)),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

