import 'dart:convert';
import 'dart:ui';

import 'package:homepage_ui/apis/hp_api.dart';
import 'package:homepage_ui/configs/hp_env.dart';
import 'package:homepage_ui/enums/hp_content_type.dart';
import 'package:http/http.dart';

class HpContentApi extends HpApi {
  Future<dynamic> getContent(HpContentType contentType, Locale locale) async {
    Response res = await super.get("/content/${contentType.jsonValue}", url: HpEnv.hpApiUrl, locale: locale);
    return res.statusCode == 200 ? json.decode(utf8.decode(res.bodyBytes)) : null;
  }
}
