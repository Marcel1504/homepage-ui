import 'package:json_annotation/json_annotation.dart';

part 'hp_content_job_task_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpContentJobTaskData {
  HpContentJobTaskData({this.task, this.dateFrom, this.dateTo});

  String? task;
  String? dateFrom;
  String? dateTo;

  factory HpContentJobTaskData.fromJson(Map<String, dynamic> json) => _$HpContentJobTaskDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpContentJobTaskDataToJson(this);
}
