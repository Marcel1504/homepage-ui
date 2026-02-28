import 'dart:convert';

import 'package:flutter/services.dart';

class HpEnv {
  static String? hpApiUrl;
  static String? hpChatConsent;

  static Future<void> load() async {
    final jsonString = await rootBundle.loadString("assets/configs/environment.json");
    final json = jsonDecode(jsonString);
    hpApiUrl = json["hpApiUrl"];
    hpChatConsent = json["hpChatConsent"];
  }
}
