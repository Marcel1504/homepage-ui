import 'package:homepage_ui/providers/data/hp_data_provider.dart';
import 'package:provider/provider.dart';

class HpProvider {
  List<ChangeNotifierProvider> get() {
    return [ChangeNotifierProvider<HpDataProvider>(create: (context) => HpDataProvider())];
  }
}
