import 'package:json_annotation/json_annotation.dart';

enum HpChatMessageType {
  @JsonValue("TEXT")
  text,
  @JsonValue("ERROR")
  error,
}
