import 'package:homepage_ui/data/error/hp_error_data.dart';

class HpException implements Exception {
  final HpErrorData? error;

  HpException(this.error);
}
