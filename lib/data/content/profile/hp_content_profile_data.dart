import 'package:json_annotation/json_annotation.dart';

part 'hp_content_profile_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpContentProfileData {
  HpContentProfileData({this.firstName, this.lastName, this.birthdate, this.birthplace});

  String? firstName;
  String? lastName;
  String? birthdate;
  String? birthplace;
  String? bio;
  String? profileMedia;

  factory HpContentProfileData.fromJson(Map<String, dynamic> json) => _$HpContentProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpContentProfileDataToJson(this);
}
