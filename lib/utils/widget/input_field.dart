import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:type1dm_rl_flutter/constants.dart';

Widget buildTextFieldWithIcon({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required String placeholder,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: kFormLabelTextStyle,
      ),
      const SizedBox(height: 5),
      Container(
        constraints: BoxConstraints(minHeight: 50.0), // この行を追加
        child: CupertinoTextField(
          style: TextStyle(color: ColorConstants.pandaBlack),
          controller: controller,
          placeholder: placeholder,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Icon(icon),
          ),
          decoration: BoxDecoration(
            color: ColorConstants.fieldGrey,
          ),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget buildNumberFieldWithIcon({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required String placeholder,
  int? maxWidth,  // maxWidthをオプショナルにし、デフォルトをnullにします。
  String? unit,
  bool allowDecimal = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: kFormLabelTextStyle,
      ),
      const SizedBox(height: 5),
      Row(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: 50.0,
              maxWidth: unit != null && maxWidth != null ? maxWidth.toDouble() : double.infinity,  // maxWidthの制限を適用する条件を追加します。
            ),
            child: CupertinoTextField(
              style: TextStyle(color: ColorConstants.pandaBlack),
              controller: controller,
              placeholder: placeholder,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              prefix: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Icon(icon),
              ),
              decoration: BoxDecoration(
                color: ColorConstants.fieldGrey,
              ),
              keyboardType: allowDecimal ? TextInputType.numberWithOptions(decimal: true) : TextInputType.number,
              inputFormatters: allowDecimal
                  ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{?}'))]
                  : [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          if (unit != null) ...[
            SizedBox(width: 5.0),
            Text(unit),
          ],
        ],
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget buildSelectFieldWithIcon({
  required String label,
  required IconData icon,
  required List<String> options,
  required Function(String?) onValueChanged,
  String? selectedValue,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: kFormLabelTextStyle,
      ),
      const SizedBox(height: 5),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        constraints: BoxConstraints(minHeight: 50.0), // この行を追加
        decoration: BoxDecoration(
          color: ColorConstants.fieldGrey,
        ),
        child: DropdownButtonHideUnderline(
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 16.0),
              Expanded(
                child: DropdownButton<String>(
                  value: selectedValue,
                  items: options.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: onValueChanged,
                  isExpanded: true,
                  icon: SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget buildDateFieldWithIcon({
  required BuildContext context,
  required String label,
  required IconData icon,
  required DateTime initialDate,
  required ValueChanged<DateTime> onDateChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: kFormLabelTextStyle,
      ),
      const SizedBox(height: 5),
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext builder) {
              return Container(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: onDateChanged,
                ),
              );
            },
          );
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 50.0),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: ColorConstants.fieldGrey,
          ),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  DateFormat('yyyy-MM-dd').format(initialDate),
                  style: TextStyle(color: ColorConstants.pandaBlack),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
