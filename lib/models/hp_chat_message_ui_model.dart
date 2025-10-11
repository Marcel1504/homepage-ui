import 'package:homepage_ui/enums/hp_chat_message_type.dart';

class HpChatMessageUiModel {
  HpChatMessageUiModel({this.content, this.type, this.isUserMessage = true});

  String? content;
  HpChatMessageType? type;
  bool isUserMessage;
}
