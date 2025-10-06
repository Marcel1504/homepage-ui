import 'package:json_annotation/json_annotation.dart';

part 'hp_content_certification_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpContentCertificationData {
  HpContentCertificationData({this.title, this.description, this.dateFrom, this.dateTo});

  String? title;
  String? description;
  String? dateFrom;
  String? dateTo;

  factory HpContentCertificationData.fromJson(Map<String, dynamic> json) => _$HpContentCertificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpContentCertificationDataToJson(this);
}
