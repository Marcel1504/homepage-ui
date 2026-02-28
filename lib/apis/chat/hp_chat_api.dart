import 'dart:convert';

import 'package:homepage_ui/apis/hp_api.dart';
import 'package:homepage_ui/configs/hp_env.dart';
import 'package:homepage_ui/data/chat/hp_chat_data.dart';
import 'package:http/http.dart';

class HpChatApi extends HpApi {
  Future<HpChatData?> postChatMessage(String content, {int? chatId}) async {
    String? chatConsent = HpEnv.hpChatConsent;
    Object body = json.encode({
      "message": content,
      if (chatConsent != null) "consent": chatConsent,
      if (chatId != null) "chatId": chatId.toString(),
    });
    Response res = await super.post("/chat", body: body, url: HpEnv.hpApiUrl);
    return res.statusCode == 200 ? HpChatData.fromJson(json.decode(utf8.decode(res.bodyBytes))) : null;
  }
}
