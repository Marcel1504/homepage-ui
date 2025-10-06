import 'package:flutter/material.dart';
import 'package:homepage_ui/data/error/hp_error_data.dart';
import 'package:homepage_ui/enums/hp_content_type.dart';
import 'package:homepage_ui/models/hp_content_model.dart';
import 'package:homepage_ui/providers/content/hp_content_provider.dart';
import 'package:homepage_ui/providers/media/hp_media_provider.dart';
import 'package:provider/provider.dart';

abstract class HpContentLoaderService<T> {
  void load(BuildContext context) {
    HpMediaProvider mediaProvider = Provider.of<HpMediaProvider>(context, listen: false);
    HpContentProvider contentProvider = Provider.of<HpContentProvider>(context, listen: false);
    contentProvider.loadContent(getType(), Localizations.localeOf(context)).then((success) {
      if (success) {
        try {
          T data = getDataFromJson(contentProvider.contentDataMap[getType()]);
          Set<String> mediaNames = getMediaNamesToLoad(data);
          for (String mediaName in mediaNames) {
            mediaProvider.loadByMediaName(mediaName);
          }
        } catch (_) {}
      }
    });
  }

  HpContentModel<T> get(BuildContext context, HpContentProvider provider) {
    HpContentModel<T> model = HpContentModel();
    model.isLoading = provider.contentLoadingSet.contains(getType());
    model.error = provider.contentErrorMap[getType()]?.error;
    if (provider.contentDataMap.containsKey(getType())) {
      try {
        model.data = getDataFromJson(provider.contentDataMap[getType()]);
      } catch (e) {
        model.error = HpErrorData(code: HpErrorCode.hp9999);
      }
    }
    return model;
  }

  @protected
  HpContentType getType();

  @protected
  T getDataFromJson(dynamic json);

  @protected
  Set<String> getMediaNamesToLoad(T data);
}
