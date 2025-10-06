import 'package:flutter/material.dart';
import 'package:homepage_ui/themes/hp_icon_theme.dart';
import 'package:json_annotation/json_annotation.dart';

enum HpContentSocialLinkType {
  @JsonValue("INSTAGRAM")
  instagram,
  @JsonValue("FACEBOOK")
  facebook,
  @JsonValue("XING")
  xing,
  @JsonValue("YOUTUBE")
  youtube,
  @JsonValue("X")
  x,
  @JsonValue("GITHUB")
  github,
  @JsonValue("LINKEDIN")
  linkedin,
}

extension HpContentSocialLinkTypeExtension on HpContentSocialLinkType {
  String get jsonValue => name.toUpperCase();

  IconData get icon {
    switch (this) {
      case HpContentSocialLinkType.instagram:
        return HpIconTheme.instagram;
      case HpContentSocialLinkType.facebook:
        return HpIconTheme.facebook;
      case HpContentSocialLinkType.xing:
        return HpIconTheme.xing;
      case HpContentSocialLinkType.youtube:
        return HpIconTheme.youtube;
      case HpContentSocialLinkType.x:
        return HpIconTheme.x;
      case HpContentSocialLinkType.github:
        return HpIconTheme.github;
      case HpContentSocialLinkType.linkedin:
        return HpIconTheme.linkedin;
    }
  }
}
