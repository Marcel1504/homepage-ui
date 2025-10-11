import 'package:homepage_ui/enums/hp_chat_message_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hp_chat_message_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpChatMessageData {
  HpChatMessageData({this.content, this.type});

  String? content;
  HpChatMessageType? type;

  factory HpChatMessageData.fromJson(Map<String, dynamic> json) => _$HpChatMessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpChatMessageDataToJson(this);
}
