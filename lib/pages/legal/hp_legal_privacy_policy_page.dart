import 'package:flutter/material.dart';
import 'package:homepage_ui/components/scaffold/hp_detail_scaffold_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';

class HpLegalPrivacyPolicyPage extends StatelessWidget {
  const HpLegalPrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HpDetailScaffoldComponent(
      child: Text("Privacy Policy"),
      title: HpI18n.translate(context, "pages.legalPrivacyPolicy"),
    );
  }
}
