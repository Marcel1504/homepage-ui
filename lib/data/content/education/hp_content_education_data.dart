import 'package:json_annotation/json_annotation.dart';

part 'hp_content_education_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpContentEducationData {
  HpContentEducationData({this.institute, this.degree, this.dateFrom, this.dateTo});

  String? institute;
  String? degree;
  String? dateFrom;
  String? dateTo;

  factory HpContentEducationData.fromJson(Map<String, dynamic> json) => _$HpContentEducationDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpContentEducationDataToJson(this);
}
