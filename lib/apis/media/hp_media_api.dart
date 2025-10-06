import 'dart:io';

import 'package:homepage_ui/apis/hp_api.dart';
import 'package:homepage_ui/configs/hp_env.dart';
import 'package:homepage_ui/data/media/hp_media_data.dart';
import 'package:http/http.dart';

class HpMediaApi extends HpApi {
  Future<HpMediaData?> getByUuid(String mediaName) async {
    Response res = await super.get("/media/$mediaName", url: HpEnv.hpApiUrl);
    String? contentType = res.headers["content-type"];
    return res.statusCode == 200
        ? HpMediaData(
            data: res.bodyBytes,
            contentLength: res.contentLength,
            contentType: contentType != null ? ContentType.parse(contentType) : null,
          )
        : null;
  }
}
