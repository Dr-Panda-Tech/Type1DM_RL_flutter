import 'package:flutter/material.dart';

class CircleForm extends StatefulWidget {
  const CircleForm({
    Key? key,
    required this.value,
    required this.setStateParent,
    this.maxStarNum = 5,
    this.iconSize = 14.0,
  }) : super(key: key);

  final int? value;
  final void Function(int) setStateParent;
  final int maxStarNum;
  final double iconSize;

  @override
  State<CircleForm> createState() => _CircleFormState();
}

class _CircleFormState extends State<CircleForm> {
  late int value;

  @override
  void initState() {
    super.initState();

    value = widget.value ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        widget.maxStarNum,
        starWidget,
      ),
    );
  }

  Widget starWidget(int index) {
    final int starOrder = index + 1; // 左から何番目のスターか

    return IconButton(
      onPressed: () {
        setState(() {
          value = starOrder;
        });
        widget.setStateParent(starOrder);
      },
      icon: starOrder <= value
          ? Icon(
        Icons.circle,
        color: Theme.of(context).colorScheme.primary,
        size: widget.iconSize,
      )
          : Icon(
        Icons.circle,
        color: Theme.of(context).colorScheme.secondaryContainer,
        size: widget.iconSize,
      ),
    );
  }
}

class CircleFormConfirm extends StatelessWidget {
  const CircleFormConfirm({
    Key? key,
    required this.value,
    this.maxStarNum = 5,
    this.iconSize = 14.0,
  }) : super(key: key);

  final int? value;
  final int maxStarNum;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(
        maxStarNum,
            (index) => value != null && index < value!
            ? Icon(
          Icons.circle,
          color: Theme.of(context).colorScheme.primary,
          size: iconSize,
        )
            : Icon(
          Icons.circle,
          color: Theme.of(context).colorScheme.secondaryContainer,
          size: iconSize,
        ),
      ),
    );
  }
}