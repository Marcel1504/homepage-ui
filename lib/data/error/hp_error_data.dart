import 'package:json_annotation/json_annotation.dart';

part 'hp_error_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpErrorData {
  HpErrorData({this.code, this.properties});

  HpErrorCode? code;
  List<String>? properties;

  factory HpErrorData.fromJson(Map<String, dynamic> json) => _$HpErrorDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpErrorDataToJson(this);
}

enum HpErrorCode {
  @JsonValue("HP0001")
  hp0001,
  @JsonValue("HP0002")
  hp0002,
  @JsonValue("HP0003")
  hp0003,
  @JsonValue("HP0004")
  hp0004,
  @JsonValue("HP1000")
  hp1000,
  @JsonValue("HP1001")
  hp1001,
  @JsonValue("HP1002")
  hp1002,
  @JsonValue("HP2000")
  hp2000,
  @JsonValue("HP2001")
  hp2001,
  @JsonValue("HP2002")
  hp2002,
  @JsonValue("HP9990")
  hp9990,
  @JsonValue("HP9999")
  hp9999,
}

extension HpErrorCodeExtension on HpErrorCode {
  String get jsonValue => name.toUpperCase();
}
