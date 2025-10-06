import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:homepage_ui/apis/media/hp_media_api.dart';
import 'package:homepage_ui/data/media/hp_media_data.dart';
import 'package:homepage_ui/exceptions/hp_exception.dart';

class HpMediaProvider extends ChangeNotifier {
  final HpMediaApi _mediaApi = HpMediaApi();
  final Map<String, HpMediaData> _mediaCache = {};
  final List<String> _mediaAccessOrder = [];
  int _totalContentLength = 0;
  final int _maxCacheSize = 10 * 1024 * 1024; // 10MB

  Future<void>? loadByMediaName(String mediaName) {
    _updateAccessOrder(mediaName);
    HpMediaData? existing = _mediaCache[mediaName];
    bool hasExistingData = existing != null && existing.data != null;
    bool isExistingLoading = existing != null && existing.loading;
    int existingContentLength = existing?.contentLength ?? 0;

    // update media to cache if it does not exist yet or it has no media data
    // skip, if media is currently loading
    if (!isExistingLoading && !hasExistingData) {
      HpMediaData media = HpMediaData();
      _mediaCache[mediaName] = media;
      return Future.microtask(() async {
        try {
          notifyListeners();
          await _loadToMedia(mediaName, media);
          _totalContentLength += (media.contentLength ?? 0) - existingContentLength;
          log("[MEDIA] Loaded $mediaName (${media.contentLength} bytes) | Total cache: $_totalContentLength bytes");
          _evictCache();
        } on HpException catch (_) {
        } finally {
          media.loading = false;
          notifyListeners();
        }
      });
    }
    return null;
  }

  /// load media data by uuid from the API into a media model object
  Future<void> _loadToMedia(String uuid, HpMediaData media) async {
    HpMediaData? mediaLoaded = await _mediaApi.getByUuid(uuid);
    media.contentLength = mediaLoaded?.contentLength;
    media.contentType = mediaLoaded?.contentType;
    media.data = mediaLoaded?.data;
  }

  /// update last recently used media
  void _updateAccessOrder(String uuid) {
    _mediaAccessOrder.remove(uuid);
    _mediaAccessOrder.add(uuid);
  }

  /// Evict last recently used media items from mediaCache until total content length is within limit
  /// Always keep the most recently used media item
  void _evictCache() {
    while (_totalContentLength > _maxCacheSize && _mediaAccessOrder.length > 1) {
      String uuidToRemove = _mediaAccessOrder.removeAt(0);
      HpMediaData? media = _mediaCache.remove(uuidToRemove);
      _totalContentLength -= media?.contentLength ?? 0;
      log("[MEDIA] Evicted ${media?.contentLength ?? 0} bytes from cache | Total cache: $_totalContentLength bytes");
    }
  }

  Map<String, HpMediaData> get mediaCache => _mediaCache;

  int get totalContentLength => _totalContentLength;
}
