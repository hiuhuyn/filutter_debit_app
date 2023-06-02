import 'package:flutter/material.dart';
import 'package:ghino_gas_flutter/res/colors.dart';
import 'package:ghino_gas_flutter/res/text_style.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double radius;
  final bool isOutLine;
  final double width;
  final double heigth;
  final TextStyle? textStyle;
  final FocusNode? focusNode;

  const RoundButton(
      {super.key,
      required this.title,
      this.backgroundColor = Colors.lightBlue,
      this.loading = false,
      this.radius = 5,
      required this.onPressed,
      this.isOutLine = false,
      this.width = double.infinity,
      this.heigth = 50,
      this.textStyle,
      this.focusNode});
  @override
  Widget build(BuildContext context) {
    if (isOutLine) {
      return OutlinedButton(
        onPressed: onPressed,
        focusNode: focusNode,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(width: 2, color: Colors.grey.shade500),
            ),
            minimumSize: MaterialStateProperty.all(Size(width, heigth))),
        child: _childButton(),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          minimumSize: MaterialStateProperty.all(Size(width, heigth))),
      child: _childButton(),
    );
  }

  Widget _childButton() {
    return loading
        ? Container(
            height: heigth - 10,
            padding: const EdgeInsets.all(8),
            child: const FittedBox(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Colors.white,
              ),
            ),
          )
        : Text(
            title,
            style: textStyle ??
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          );
  }
}
