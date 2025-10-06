import 'package:homepage_ui/data/error/hp_error_data.dart';

class HpContentModel<T> {
  HpContentModel({this.data, this.error, this.isLoading = false});

  T? data;
  HpErrorData? error;
  bool isLoading;
}
