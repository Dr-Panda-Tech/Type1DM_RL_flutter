import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:type1dm_rl_flutter/constants.dart';

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

    int dotCount = '.'.allMatches(truncated).length;
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
    return GestureDetector(
      // Detecting taps on the whole screen.
      onTap: () => primaryFocus?.unfocus(),
      child: Column(
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
                  maxHeight: 50.0,
                  maxWidth: unit != null && maxWidth != null
                      ? maxWidth.toDouble()
                      : double.infinity,
                ),
                child: CupertinoTextField(
                  maxLines: 1,
                  style: TextStyle(color: ColorConstants.pandaBlack),
                  controller: controller,
                  placeholder: placeholder,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Icon(icon),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),  // この行を追加
                    color: ColorConstants.fieldGrey,
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: allowDecimal),
                  inputFormatters: [
                    allowDecimal
                        ? DecimalPointInputFormatter(decimal: decimal)
                        : FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              if (unit != null) ...[
                SizedBox(width: 5.0),
                Text(unit),
              ],
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildNumberField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String placeholder,
    int? maxWidth,
    String? unit,
    bool allowDecimal = false,
    int decimal = 1,
  }) {
    return GestureDetector(
      // Detecting taps on the whole screen.
      onTap: () => primaryFocus?.unfocus(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Row(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: 50.0,
                  maxHeight: 50.0,
                  maxWidth: unit != null && maxWidth != null
                      ? maxWidth.toDouble()
                      : double.infinity,
                ),
                child: CupertinoTextField(
                  maxLines: 1,
                  style: TextStyle(color: ColorConstants.pandaBlack),
                  controller: controller,
                  placeholder: placeholder,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                    child: Text(
                      label,
                      style: kFormLabelTextStyle,
                    ),
                  ),
                  textAlign: TextAlign.center, // テキストを右寄せにする
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),  // この行を追加
                    color: ColorConstants.fieldGrey,
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: allowDecimal),
                  inputFormatters: [
                    allowDecimal
                        ? DecimalPointInputFormatter(decimal: decimal)
                        : FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              if (unit != null) ...[
                SizedBox(width: 5.0),
                Text(unit),
              ],
            ],
          ),
        ],
      ),
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
            borderRadius: BorderRadius.circular(10.0),  // この行を追加
            color: ColorConstants.fieldGrey,
          ),
        ),
      ),
    ],
  );
}

Widget buildYearDateFieldWithIcon({
  required BuildContext context,
  required String label,
  required IconData icon,
  required DateTime initialDate,
  required ValueChanged<DateTime?> onDateChanged,
  required ValueNotifier<DateTime?> selectedDateNotifier,
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
          DateTime? tempSelectedDate = selectedDateNotifier.value ?? initialDate;
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
                            selectedDateNotifier.value = tempSelectedDate;
                            onDateChanged(tempSelectedDate);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: selectedDateNotifier.value ?? initialDate,
                        minimumDate: DateTime(1900),
                        maximumDate: DateTime.now(),
                        onDateTimeChanged: (newDate) {
                          tempSelectedDate = newDate;
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
            borderRadius: BorderRadius.circular(10.0),  // この行を追加
            color: ColorConstants.fieldGrey,
          ),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 16.0),
              Expanded(
                child: ValueListenableBuilder<DateTime?>(
                  valueListenable: selectedDateNotifier,
                  builder: (context, date, child) {
                    return Text(
                      date == null ? '選択して下さい' : DateFormat('yyyy-MM-dd').format(date),
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


Widget buildListSelectionWithIcon({
  required BuildContext context,
  required String label,
  required IconData icon,
  required List<String> options,
  required ValueChanged<String?> onSelectionChanged,
  required ValueNotifier<String?> selectedValueNotifier,
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
          String? tempSelectedValue = selectedValueNotifier.value ?? options[0];
          int initialIndex = options.indexOf(tempSelectedValue);
          if (initialIndex == -1) initialIndex = 0;

          FixedExtentScrollController scrollController = FixedExtentScrollController(initialItem: initialIndex);

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
                          child: Text("キャンセル",style: kColorTextStyle,),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        CupertinoButton(
                          child: Text("確定",style: kColorTextStyle,),
                          onPressed: () {
                            selectedValueNotifier.value = tempSelectedValue;
                            onSelectionChanged(tempSelectedValue);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: scrollController,
                        onSelectedItemChanged: (int index) {
                          tempSelectedValue = options[index];
                        },
                        itemExtent: 32.0,
                        children: options.map((String value) {
                          return Text(value);
                        }).toList(),
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
            borderRadius: BorderRadius.circular(10.0),
            color: ColorConstants.fieldGrey,
          ),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 16.0),
              Expanded(
                child: ValueListenableBuilder<String?>(
                  valueListenable: selectedValueNotifier,
                  builder: (context, value, child) {
                    return Text(value ?? '選択して下さい');
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
