import 'package:flutter/material.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:intl/intl.dart';

class HpTimeService {
  static const String isoDayPattern = "yyyy-MM-dd";
  static const String prettyMonthPattern = "MM/yyyy";

  String? transformDateTimeString(
    BuildContext context,
    String? dateTime, {
    String inputPattern = HpTimeService.isoDayPattern,
    String outputPattern = prettyMonthPattern,
    bool strict = true,
    bool utc = true,
  }) {
    try {
      DateTime? parsed = parseDateTime(dateTime, pattern: inputPattern, strict: strict, utc: utc);
      if (parsed != null) {
        DateFormat output = DateFormat(outputPattern, Localizations.localeOf(context).languageCode);
        return output.format(parsed);
      }
    } on Exception catch (_) {}
    return null;
  }

  DateTime? parseDateTime(String? dateTime, {bool strict = true, bool utc = true, String pattern = isoDayPattern}) {
    try {
      if (dateTime != null) {
        return strict ? DateFormat(pattern).parseStrict(dateTime, utc) : DateFormat(pattern).parse(dateTime, utc);
      }
    } on Exception catch (_) {}
    return null;
  }

  String transformMonthRangeString(BuildContext context, String? dateFrom, String? dateTo) {
    String finalDateFrom =
        transformDateTimeString(
          context,
          dateFrom,
          inputPattern: HpTimeService.isoDayPattern,
          outputPattern: HpTimeService.prettyMonthPattern,
        ) ??
        HpI18n.translate(context, "time.unknown");
    String finalDateTo =
        transformDateTimeString(
          context,
          dateTo,
          inputPattern: HpTimeService.isoDayPattern,
          outputPattern: HpTimeService.prettyMonthPattern,
        ) ??
        HpI18n.translate(context, "time.today");
    return "$finalDateFrom - $finalDateTo";
  }
}
