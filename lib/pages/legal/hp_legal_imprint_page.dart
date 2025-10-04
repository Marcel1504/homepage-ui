import 'package:flutter/material.dart';
import 'package:homepage_ui/components/scaffold/hp_detail_scaffold_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';

class HpLegalImprintPage extends StatelessWidget {
  const HpLegalImprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HpDetailScaffoldComponent(child: Text("Imprint"), title: HpI18n.translate(context, "pages.legalImprint"));
  }
}
