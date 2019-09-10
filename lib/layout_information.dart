import 'package:flutter/material.dart';

class LayoutInformation {
  LayoutInformation(BuildContext context)
      : deviceSize = MediaQuery.of(context).size,
        devicePadding = MediaQuery.of(context).padding,
        isTablet = MediaQuery.of(context).size.shortestSide < 500,
        isLandscape = MediaQuery.of(context).size.height < MediaQuery.of(context).size.width,
        locale = Localizations.localeOf(context);

  final Size deviceSize;
  final EdgeInsets devicePadding;
  final bool isTablet;
  final bool isLandscape;
  final Locale locale;
}
