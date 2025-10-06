import 'dart:io';
import 'dart:typed_data';

class HpMediaData {
  HpMediaData({this.data, this.contentType, this.contentLength, this.loading = true});

  Uint8List? data;
  ContentType? contentType;
  int? contentLength;
  bool loading;
}
