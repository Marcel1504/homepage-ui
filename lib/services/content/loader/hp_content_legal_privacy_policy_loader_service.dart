import 'package:homepage_ui/data/content/legal/hp_content_legal_data.dart';
import 'package:homepage_ui/enums/hp_content_type.dart';
import 'package:homepage_ui/services/content/loader/hp_content_loader_service.dart';

class HpContentLegalPrivacyPolicyLoaderService extends HpContentLoaderService<HpContentLegalData> {
  @override
  HpContentType getType() {
    return HpContentType.legalPrivacyPolicy;
  }

  @override
  HpContentLegalData getDataFromJson(json) {
    return HpContentLegalData.fromJson(json);
  }

  @override
  Set<String> getMediaNamesToLoad(HpContentLegalData data) {
    return {};
  }
}
