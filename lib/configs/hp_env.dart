import 'dart:convert';

import 'package:flutter/services.dart';

class HpEnv {
  static String? hpApiUrl;

  static Future<void> load() async {
    final jsonString = await rootBundle.loadString("environment.json");
    final json = jsonDecode(jsonString);
    hpApiUrl = json["hpApiUrl"];
  }
}
