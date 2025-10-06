import 'package:homepage_ui/data/content/profile/hp_content_profile_data.dart';
import 'package:homepage_ui/enums/hp_content_type.dart';
import 'package:homepage_ui/services/content/loader/hp_content_loader_service.dart';

class HpContentProfileLoaderService extends HpContentLoaderService<HpContentProfileData> {
  @override
  HpContentType getType() {
    return HpContentType.profile;
  }

  @override
  HpContentProfileData getDataFromJson(json) {
    return HpContentProfileData.fromJson(json);
  }

  @override
  Set<String> getMediaNamesToLoad(HpContentProfileData data) {
    return {if (data.profileMedia != null) data.profileMedia!};
  }
}
