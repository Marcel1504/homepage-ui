import 'package:homepage_ui/data/content/jobs/hp_content_job_data.dart';
import 'package:homepage_ui/enums/hp_content_type.dart';
import 'package:homepage_ui/services/content/loader/hp_content_loader_service.dart';

class HpContentJobsLoaderService extends HpContentLoaderService<List<HpContentJobData>> {
  @override
  HpContentType getType() {
    return HpContentType.jobs;
  }

  @override
  List<HpContentJobData> getDataFromJson(json) {
    return (json as List<dynamic>).map((e) => HpContentJobData.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Set<String> getMediaNamesToLoad(List<HpContentJobData> data) {
    return {};
  }
}
