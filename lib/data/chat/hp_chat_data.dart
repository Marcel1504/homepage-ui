import 'package:homepage_ui/data/chat/hp_chat_message_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hp_chat_data.g.dart';

@JsonSerializable(explicitToJson: true)
class HpChatData {
  HpChatData({this.chatId, this.messages});

  int? chatId;
  List<HpChatMessageData>? messages;

  factory HpChatData.fromJson(Map<String, dynamic> json) => _$HpChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$HpChatDataToJson(this);
}
