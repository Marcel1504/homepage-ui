import 'package:json_annotation/json_annotation.dart';

enum HpContentType {
  @JsonValue("LEGAL_IMPRINT")
  legalImprint,
  @JsonValue("LEGAL_PRIVACY_POLICY")
  legalPrivacyPolicy,
  @JsonValue("PROFILE")
  profile,
  @JsonValue("PROJECTS")
  projects,
  @JsonValue("JOBS")
  jobs,
  @JsonValue("CERTIFICATIONS")
  certifications,
  @JsonValue("EDUCATION")
  education,
  @JsonValue("SOCIAL_LINKS")
  socialLinks,
}

extension HpContentTypeExtension on HpContentType {
  String get jsonValue {
    switch (this) {
      case HpContentType.legalImprint:
        return "LEGAL_IMPRINT";
      case HpContentType.legalPrivacyPolicy:
        return "LEGAL_PRIVACY_POLICY";
      case HpContentType.socialLinks:
        return "SOCIAL_LINKS";
      default:
        return name.toUpperCase();
    }
  }
}
