import 'package:flutter/cupertino.dart';
import 'package:homepage_ui/apis/content/hp_content_api.dart';
import 'package:homepage_ui/enums/hp_content_type.dart';
import 'package:homepage_ui/exceptions/hp_exception.dart';

class HpContentProvider extends ChangeNotifier {
  final HpContentApi contentApi = HpContentApi();

  final Set<HpContentType> _contentLoadingSet = {};
  final Map<HpContentType, HpException?> _contentErrorMap = {};
  final Map<HpContentType, dynamic> _contentDataMap = {};

  Future<bool> loadContent(HpContentType contentType, Locale locale, {bool forceReload = false}) async {
    if (_contentDataMap.containsKey(contentType) && !forceReload) {
      return true;
    }
    return Future.microtask(() async {
      bool success = false;
      try {
        _contentDataMap.remove(contentType);
        _contentErrorMap.remove(contentType);
        _contentLoadingSet.add(contentType);
        notifyListeners();
        final data = await contentApi.getContent(contentType, locale);
        _contentDataMap[contentType] = data;
        success = true;
      } on HpException catch (ex) {
        _contentErrorMap[contentType] = ex;
      } finally {
        _contentLoadingSet.remove(contentType);
        notifyListeners();
      }
      return success;
    });
  }

  Map<HpContentType, dynamic> get contentDataMap => _contentDataMap;

  Map<HpContentType, HpException?> get contentErrorMap => _contentErrorMap;

  Set<HpContentType> get contentLoadingSet => _contentLoadingSet;
}
