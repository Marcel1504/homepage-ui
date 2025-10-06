import 'dart:convert';
import 'dart:ui';

import 'package:homepage_ui/data/error/hp_error_data.dart';
import 'package:homepage_ui/exceptions/hp_exception.dart';
import 'package:http/http.dart' as http;

abstract class HpApi {
  Future<http.Response> get(String path, {Map<String, dynamic>? params, String? url, Locale? locale}) async {
    call() async => http.get(
      _generateUri(path, params: params, url: url),
      headers: _getHeaders(locale),
    );
    return _handleCall(call);
  }

  Future<http.Response> put(
    String path, {
    Object? body,
    Map<String, dynamic>? params,
    String? url,
    Locale? locale,
  }) async {
    call() async => http.put(
      _generateUri(path, url: url),
      body: body,
      headers: _getHeaders(locale),
    );
    return _handleCall(call);
  }

  Future<http.Response> post(
    String path, {
    Object? body,
    Map<String, dynamic>? params,
    String? url,
    Locale? locale,
  }) async {
    call() async => http.post(
      _generateUri(path, url: url),
      body: body,
      headers: _getHeaders(locale),
    );
    return _handleCall(call);
  }

  Future<http.Response> delete(
    String path, {
    Object? body,
    Map<String, dynamic>? params,
    String? url,
    Locale? locale,
  }) async {
    call() async => http.delete(
      _generateUri(path, params: params, url: url),
      body: body,
      headers: _getHeaders(locale),
    );
    return _handleCall(call);
  }

  Map<String, String> _getHeaders(Locale? locale) {
    return {"Content-Type": "application/json", "Accept-Language": locale?.countryCode ?? 'en'};
  }

  Uri _generateUri(String endpoint, {Map<String, dynamic>? params, String? url}) {
    Uri origin = Uri.parse("$url$endpoint");
    return Uri(scheme: origin.scheme, host: origin.host, port: origin.port, path: origin.path, queryParameters: params);
  }

  Future<http.Response> _handleCall(Future<http.Response> Function() call) async {
    return await _handleCallWithCustomErrorHandling(call);
  }

  Future<http.Response> _handleCallWithCustomErrorHandling(Future<http.Response> Function() call) async {
    http.Response res;
    try {
      res = await call();
    } catch (_) {
      throw HpException(HpErrorData(code: HpErrorCode.hp9999));
    }
    if (!(res.statusCode >= 200 && res.statusCode < 400)) {
      HpErrorData? data;
      try {
        data = HpErrorData.fromJson(json.decode(utf8.decode(res.bodyBytes)));
      } catch (_) {
        data = HpErrorData(code: HpErrorCode.hp9999);
      }
      throw HpException(data);
    }
    return res;
  }
}
