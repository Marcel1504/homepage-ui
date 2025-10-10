import 'package:homepage_ui/data/content/projects/hp_content_project_data.dart';
import 'package:homepage_ui/enums/hp_content_type.dart';
import 'package:homepage_ui/services/content/loader/hp_content_loader_service.dart';

class HpContentProjectsLoaderService extends HpContentLoaderService<List<HpContentProjectData>> {
  @override
  HpContentType getType() {
    return HpContentType.projects;
  }

  @override
  List<HpContentProjectData> getDataFromJson(json) {
    return (json as List<dynamic>).map((e) => HpContentProjectData.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Set<String> getMediaNamesToLoad(List<HpContentProjectData> data) {
    return data.where((d) => d.thumbnailMedia != null).map((d) => d.thumbnailMedia!).toSet();
  }
}
