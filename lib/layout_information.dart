import 'package:flutter/material.dart';
import 'package:provider_assist/provider_assist.dart';

class LayoutInformation {
  LayoutInformation(BuildContext context)
      : context = context,
        deviceSize = MediaQuery.of(context).size,
        devicePadding = MediaQuery.of(context).padding,
        deviceType = getDeviceTypeFromContext(context),
        orientation = MediaQuery.of(context).orientation,
        locale = Localizations.localeOf(context),
        translations =
            getTranslationsForLocale(Localizations.localeOf(context)),
        theme = Theme.of(context);

  final BuildContext context;
  final Size deviceSize;
  final EdgeInsets devicePadding;
  final DeviceType deviceType;
  final Orientation orientation;
  final Locale locale;
  final Map<String, String> translations;
  final ThemeData theme;

  static const double phoneShortestWidthThreshold = 320.0;
  static const double tabletShortestWidthThreshold = 600.0;
  static const double desktopShortestWidthThreshold = 900.0;
}

DeviceType getDeviceTypeFromContext(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  final double shortestSize = size.shortestSide;

  DeviceType type = DeviceType.Watch;
  if (shortestSize >= LayoutInformation.phoneShortestWidthThreshold) {
    type = DeviceType.Phone;
  }

  if (shortestSize >= LayoutInformation.tabletShortestWidthThreshold) {
    type = DeviceType.Tablet;
  }

  if (shortestSize >= LayoutInformation.desktopShortestWidthThreshold) {
    type = DeviceType.Desktop;
  }

  return type;
}
