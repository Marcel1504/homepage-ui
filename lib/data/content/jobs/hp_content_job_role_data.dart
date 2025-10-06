import 'package:json_annotation/json_annotation.dart';

part 'hp_content_job_role_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpContentJobRoleData {
  HpContentJobRoleData({this.role, this.dateFrom, this.dateTo});

  String? role;
  String? dateFrom;
  String? dateTo;

  factory HpContentJobRoleData.fromJson(Map<String, dynamic> json) => _$HpContentJobRoleDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpContentJobRoleDataToJson(this);
}
