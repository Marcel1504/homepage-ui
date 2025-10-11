import 'package:flutter/cupertino.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/data/error/hp_error_data.dart';

class HpErrorService {
  String createMessage(BuildContext context, HpErrorData? error) {
    return error != null
        ? createMessageFromErrorData(context, error.code, error.properties ?? [])
        : HpI18n.translate(context, "error.unknown");
  }

  String createMessageFromErrorData(BuildContext context, HpErrorCode? code, List<String> properties) {
    return _getErrorMap(context, properties)[code] ?? HpI18n.translate(context, "error.unknown");
  }

  Map<HpErrorCode, String> _getErrorMap(BuildContext context, List<String> properties) {
    String prop1 = properties.isNotEmpty ? properties[0].toString() : "?";
    String prop2 = properties.length > 1 ? properties[1].toString() : "?";
    return {
      HpErrorCode.hp0001: HpI18n.translate(context, "error.hp0001", p: {"type": prop1, "lang": prop2}),
      HpErrorCode.hp0002: HpI18n.translate(context, "error.hp0002"),
      HpErrorCode.hp0003: HpI18n.translate(context, "error.hp0003"),
      HpErrorCode.hp0004: HpI18n.translate(context, "error.hp0004"),
      HpErrorCode.hp1000: HpI18n.translate(context, "error.hp1000"),
      HpErrorCode.hp1001: HpI18n.translate(context, "error.hp1001"),
      HpErrorCode.hp1002: HpI18n.translate(context, "error.hp1002"),
      HpErrorCode.hp1003: HpI18n.translate(context, "error.hp1003"),
      HpErrorCode.hp2000: HpI18n.translate(context, "error.hp2000", p: {"name": prop1}),
      HpErrorCode.hp2001: HpI18n.translate(context, "error.hp2001"),
      HpErrorCode.hp2002: HpI18n.translate(context, "error.hp2002"),
      HpErrorCode.hp9990: HpI18n.translate(context, "error.hp9990"),
      HpErrorCode.hp9999: HpI18n.translate(context, "error.unknown"),
    };
  }
}
