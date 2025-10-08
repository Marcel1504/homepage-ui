import 'package:homepage_ui/data/content/certifications/hp_content_certification_data.dart';
import 'package:homepage_ui/enums/hp_content_type.dart';
import 'package:homepage_ui/services/content/loader/hp_content_loader_service.dart';

class HpContentCertificationLoaderService extends HpContentLoaderService<List<HpContentCertificationData>> {
  @override
  HpContentType getType() {
    return HpContentType.certifications;
  }

  @override
  List<HpContentCertificationData> getDataFromJson(json) {
    return (json as List<dynamic>).map((e) => HpContentCertificationData.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Set<String> getMediaNamesToLoad(List<HpContentCertificationData> data) {
    return {};
  }
}
