import 'package:homepage_ui/enums/hp_content_social_link_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hp_content_social_link_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpContentSocialLinkData {
  HpContentSocialLinkData({this.type, this.link});

  HpContentSocialLinkType? type;
  String? link;

  factory HpContentSocialLinkData.fromJson(Map<String, dynamic> json) => _$HpContentSocialLinkDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpContentSocialLinkDataToJson(this);
}
