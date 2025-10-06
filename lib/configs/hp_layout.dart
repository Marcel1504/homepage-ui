import 'package:flutter/material.dart';

class HpLayout {
  // app bar
  static const double appBarHeight = 64;
  static const double appBarSpacing = 14;

  // button
  static const double buttonAppBarSize = appBarHeight - (2 * appBarSpacing);
  static const double buttonAppBarTextSize = buttonAppBarSize * 0.5;

  static const double buttonDefaultIconSize = 24;
  static const double buttonDefaultSize = 48;
  static const double buttonDefaultTextSize = 0.45;

  static const double buttonFooterSize = 26;
  static const double buttonFooterTextSize = 14;

  static const double buttonNavigationMobileIconSize = 24;
  static const double buttonNavigationMobileSize = 55;
  static const double buttonNavigationMobileTextSize = 14;

  static const double buttonSocialLinkSize = 50;

  // image
  static const double imageProfileDesktopSize = 300;
  static const double imageProfileMobileSize = 250;

  // page
  static const double pageDefaultSpacing = 12;
  static const double pageMaxWidth = 1000;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static Image getImageAsset(BuildContext context, String name) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    String mode;
    if (brightness == Brightness.dark) {
      mode = "dark";
    } else {
      mode = "light";
    }
    return Image.asset("assets/images/$name-$mode.png");
  }
}
