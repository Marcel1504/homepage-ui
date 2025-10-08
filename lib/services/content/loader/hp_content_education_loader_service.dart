import 'package:homepage_ui/data/content/education/hp_content_education_data.dart';
import 'package:homepage_ui/enums/hp_content_type.dart';
import 'package:homepage_ui/services/content/loader/hp_content_loader_service.dart';

class HpContentEducationLoaderService extends HpContentLoaderService<List<HpContentEducationData>> {
  @override
  HpContentType getType() {
    return HpContentType.education;
  }

  @override
  List<HpContentEducationData> getDataFromJson(json) {
    return (json as List<dynamic>).map((e) => HpContentEducationData.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Set<String> getMediaNamesToLoad(List<HpContentEducationData> data) {
    return {};
  }
}
