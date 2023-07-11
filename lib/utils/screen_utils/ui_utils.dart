import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/screen_utils/size_config.dart';

import '../enums.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQueryData) {
  double deviceWidth = mediaQueryData.size.shortestSide;

  if (deviceWidth > 950) {
    return DeviceScreenType.desktop;
  } else if (deviceWidth > 600) {
    return DeviceScreenType.tablet;
  } else {
    return DeviceScreenType.mobile;
  }
}

OutlineInputBorder searchInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    1.5.vdp(),
  ),
  borderSide: BorderSide(
    width: 0.vdp(),
    color: Colors.transparent,
  ),
);
double getScaledImageHeight(
    double imageHeight, double imageWidth, double maxWidth) {
  return (imageHeight * maxWidth) / imageWidth;
}
