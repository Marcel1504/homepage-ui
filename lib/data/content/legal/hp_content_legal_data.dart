import 'package:json_annotation/json_annotation.dart';

part 'hp_content_legal_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpContentLegalData {
  HpContentLegalData({this.html});

  String? html;

  factory HpContentLegalData.fromJson(Map<String, dynamic> json) => _$HpContentLegalDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpContentLegalDataToJson(this);
}
