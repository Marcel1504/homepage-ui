import 'package:homepage_ui/data/content/jobs/hp_content_job_role_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hp_content_job_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpContentJobData {
  HpContentJobData({this.company, this.dateFrom, this.dateTo, this.roles, this.tasks});

  String? company;
  String? dateFrom;
  String? dateTo;
  List<HpContentJobRoleData>? roles;
  List<String>? tasks;

  factory HpContentJobData.fromJson(Map<String, dynamic> json) => _$HpContentJobDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpContentJobDataToJson(this);
}
