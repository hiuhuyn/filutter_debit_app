import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghino_gas_flutter/res/colors.dart';
import 'package:ghino_gas_flutter/res/text_style.dart';

class RoundButtonImage extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double radius;
  final String pathImage;
  final bool isOutLine;
  final double width;
  final double heigth;
  final TextStyle? textStyle;
  const RoundButtonImage(
      {super.key,
      required this.title,
      this.backgroundColor = AppColors.blue0E64D2,
      this.loading = false,
      this.radius = 5,
      required this.onPressed,
      required this.pathImage,
      this.isOutLine = false,
      this.width = double.infinity,
      this.heigth = 50,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    if (isOutLine) {
      return OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(width: 2, color: Colors.grey.shade500),
            ),
            minimumSize: MaterialStateProperty.all(Size(width, heigth)),
            maximumSize: MaterialStateProperty.all(
              Size(width, heigth + 100),
            )),
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
          maximumSize: MaterialStateProperty.all(
            Size(width, heigth + 100),
          ),
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
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                child: File(pathImage).existsSync()
                    ? SizedBox(
                        width: heigth - 20,
                        height: heigth - 20,
                      )
                    : Image(
                        image: AssetImage(pathImage),
                        width: heigth - 20,
                        height: heigth - 20,
                      ),
              ),
              Text(
                title,
                style: textStyle,
              ),
              SizedBox(
                width: heigth - 20,
                height: heigth - 20,
              ),
            ],
          );
  }
}
