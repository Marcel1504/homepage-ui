import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';

class HpI18n {
  static final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      basePath: "assets/i18ns",
      fallbackFile: "en",
      useCountryCode: false,
      decodeStrategies: [JsonDecodeStrategy()],
    ),
  );

  static String translate(BuildContext context, String key, {Map<String, String>? p}) {
    return FlutterI18n.translate(context, key, translationParams: p);
  }
}
