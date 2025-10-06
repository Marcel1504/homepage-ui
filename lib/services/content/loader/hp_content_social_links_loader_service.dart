import 'package:homepage_ui/data/content/sociallinks/hp_content_social_link_data.dart';
import 'package:homepage_ui/enums/hp_content_type.dart';
import 'package:homepage_ui/services/content/loader/hp_content_loader_service.dart';

class HpContentSocialLinksLoaderService extends HpContentLoaderService<List<HpContentSocialLinkData>> {
  @override
  HpContentType getType() {
    return HpContentType.socialLinks;
  }

  @override
  List<HpContentSocialLinkData> getDataFromJson(json) {
    return (json as List<dynamic>).map((e) => HpContentSocialLinkData.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Set<String> getMediaNamesToLoad(List<HpContentSocialLinkData> data) {
    return {};
  }
}
