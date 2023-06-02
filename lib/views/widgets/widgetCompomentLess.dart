
import 'package:flutter/material.dart';

class WidgetLess {
  static EdgeInsets edgeInsetSplitScreen(BuildContext context,
      {double left = 20,
      double right = 20,
      double top = 20,
      double bottom = 20}) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return EdgeInsets.only(
        left: width / left,
        right: width / right,
        top: height / top,
        bottom: height / bottom);
  }
}
