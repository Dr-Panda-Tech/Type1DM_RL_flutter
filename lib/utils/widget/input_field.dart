import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class DecimalPointInputFormatter extends TextInputFormatter {
  final int decimal;

  DecimalPointInputFormatter({this.decimal = 1});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String truncated = newValue.text;

    if (truncated.contains('..')) {
      truncated = truncated.replaceAll('..', '.');
    }

    int dotCount = ' '.allMatches(truncated).length;
    if (dotCount > 1) {
      truncated = truncated.substring(0, truncated.lastIndexOf('.'));
    }

    if (truncated.contains('.')) {
      int decimalIndex = truncated.indexOf('.') + 1;
      int allowedLength = decimalIndex + decimal;

      if (truncated.length > allowedLength) {
        truncated = truncated.substring(0, allowedLength);
      }
    }

    return TextEditingValue(
      text: truncated,
      selection: newValue.selection,
      composing: TextRange.empty,
    );
  }
}

class CustomFormWidgets {
  static Widget buildNumberFieldWithIcon({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String placeholder,
    int? maxWidth,
    String? unit,
    bool allowDecimal = false,
    int decimal = 1,
  }) {
    final focusNode = FocusNode();

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
                maxHeight: 50.0,  // maxHeight制約を追加します
                maxWidth: unit != null && maxWidth != null
                    ? maxWidth.toDouble()
                    : double.infinity,
              ),
              child: KeyboardActions(
                config: KeyboardActionsConfig(
                  keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                  keyboardBarColor: ColorConstants.fieldGrey,
                  nextFocus: true,
                  actions: [
                    KeyboardActionsItem(
                        focusNode: focusNode,
                        toolbarButtons: [
                              (node) {
                            return GestureDetector(
                              onTap: () => node.unfocus(),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 32.0),
                                child: Text("Done", style: kKeyboardDoneTextStyle,),
                              ),
                            );
                          }
                        ]
                    ),
                  ],
                ),
                child: CupertinoTextField(
                  focusNode: focusNode,
                  maxLines: 1,  // maxLinesを1に設定します
                  style: TextStyle(color: ColorConstants.pandaBlack,),
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
                  keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
                  inputFormatters: [
                    allowDecimal
                        ? DecimalPointInputFormatter(decimal: decimal)
                        : FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ),
            if (unit != null) ...[
              SizedBox(width: 5.0),
              Text(unit),
            ],
          ],
        ),
      ],
    );
  }
}

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
        constraints: BoxConstraints(minHeight: 50.0, maxHeight: 50.0), // この行を追加
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
        constraints: BoxConstraints(minHeight: 50.0, maxHeight: 50.0), // この行を追加
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
    ],
  );
}

Widget buildDateFieldWithIcon({
  required BuildContext context,
  required String label,
  required IconData icon,
  required DateTime initialDate,
  required ValueChanged<DateTime> onDateChanged,
  required ValueNotifier<DateTime> selectedDateNotifier, // 追加
}) {
  DateTime tempDate = initialDate;

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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          child: Text(
                            "キャンセル",
                            style: kColorTextStyle,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoButton(
                          child: Text(
                            "確定",
                            style: kColorTextStyle,
                          ),
                          onPressed: () {
                            selectedDateNotifier.value = tempDate; // ここでValueNotifierを更新
                            onDateChanged(tempDate);
                            print("Updated Date: ${selectedDateNotifier.value}"); // 確認のためのログ
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: initialDate,
                        minimumDate: DateTime(1900),
                        maximumDate: DateTime.now(),
                        onDateTimeChanged: (newDate) {
                          tempDate = newDate;
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 50.0, maxHeight: 50.0),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: ColorConstants.fieldGrey,
          ),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 16.0),
              Expanded(
                child: ValueListenableBuilder<DateTime>(
                  valueListenable: selectedDateNotifier,
                  builder: (context, date, child) {
                    return Text(
                      date == initialDate ? '選択して下さい' : DateFormat('yyyy-MM-dd').format(date),
                      style: kDateTextStyle,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
