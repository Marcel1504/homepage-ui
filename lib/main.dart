import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:homepage_ui/configs/hp_env.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_router.dart';
import 'package:homepage_ui/providers/hp_provider.dart';
import 'package:homepage_ui/themes/hp_theme_dark.dart';
import 'package:homepage_ui/themes/hp_theme_light.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await HpEnv.load();
  runApp(const HpUi());
}

class HpUi extends StatelessWidget {
  const HpUi({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: HpProvider().get(),
      child: MaterialApp.router(
        title: "Homepage",
        theme: HpThemeLight().get(),
        darkTheme: HpThemeDark().get(),
        themeMode: ThemeMode.system,
        routerConfig: HpRouter.router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          HpI18n.flutterI18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale("en"), Locale("de")],
      ),
    );
  }
}
