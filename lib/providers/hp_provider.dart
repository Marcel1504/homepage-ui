import 'package:homepage_ui/providers/chat/hp_chat_provider.dart';
import 'package:homepage_ui/providers/content/hp_content_provider.dart';
import 'package:homepage_ui/providers/media/hp_media_provider.dart';
import 'package:provider/provider.dart';

class HpProvider {
  List<ChangeNotifierProvider> get() {
    return [
      ChangeNotifierProvider<HpContentProvider>(create: (context) => HpContentProvider()),
      ChangeNotifierProvider<HpMediaProvider>(create: (context) => HpMediaProvider()),
      ChangeNotifierProvider<HpChatProvider>(create: (context) => HpChatProvider()),
    ];
  }
}
