import 'package:json_annotation/json_annotation.dart';

part 'hp_content_project_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpContentProjectData {
  HpContentProjectData({this.title, this.description, this.externalLink, this.thumbnailMedia});

  String? title;
  String? description;
  String? externalLink;
  String? thumbnailMedia;

  factory HpContentProjectData.fromJson(Map<String, dynamic> json) => _$HpContentProjectDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpContentProjectDataToJson(this);
}
