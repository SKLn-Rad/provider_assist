import 'package:flutter/material.dart';

import 'package:provider_assist/helpers/device_type.dart';
import 'package:provider_assist/provider_assist.dart';

import '../provider_assist.dart';

class LayoutInformation {
  const LayoutInformation(this.context);
  final BuildContext context;

  MediaQueryData get media => MediaQuery.of(context);
  Size get deviceSize => media.size;
  EdgeInsets get devicePadding => media.padding;
  Orientation get orientation => media.orientation;
  double get pixelRatio => media.devicePixelRatio;

  Locale get locale => Localizations.localeOf(context);
  Map<String, String> get translations => ProviderAssist.instance.getTranslationsForLocale(locale);
  ThemeData get theme => Theme.of(context);

  static const double phoneShortestWidthThreshold = 320.0;
  static const double tabletShortestWidthThreshold = 600.0;
  static const double desktopShortestWidthThreshold = 900.0;

  DeviceType get deviceType {
  final double shortestSize = deviceSize.shortestSide;

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
}
