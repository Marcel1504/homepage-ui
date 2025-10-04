import 'package:flutter/material.dart';
import 'package:homepage_ui/components/scaffold/hp_main_scaffold_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';

class HpProjectsPage extends StatelessWidget {
  const HpProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HpMainScaffoldComponent(activeActionText: HpI18n.translate(context, "pages.projects"), child: Container());
  }
}
