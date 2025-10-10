import 'package:flutter/material.dart';
import 'package:homepage_ui/components/html/hp_html_component.dart';
import 'package:homepage_ui/components/scaffold/hp_detail_scaffold_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/data/content/legal/hp_content_legal_data.dart';
import 'package:homepage_ui/models/hp_content_model.dart';
import 'package:homepage_ui/providers/content/hp_content_provider.dart';
import 'package:homepage_ui/services/content/loader/hp_content_legal_imprint_loader_service.dart';
import 'package:provider/provider.dart';

class HpLegalImprintPage extends StatefulWidget {
  const HpLegalImprintPage({super.key});

  @override
  State<HpLegalImprintPage> createState() => _HpLegalImprintPageState();
}

class _HpLegalImprintPageState extends State<HpLegalImprintPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HpContentLegalImprintLoaderService().load(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return HpDetailScaffoldComponent(
      title: HpI18n.translate(context, "pages.legalImprint"),
      child: Consumer<HpContentProvider>(
        builder: (context, provider, _) {
          HpContentModel<HpContentLegalData> imprint = HpContentLegalImprintLoaderService().get(context, provider);
          return imprint.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: HpLayout.pageMaxWidth),
                      child: HpHtmlComponent(data: imprint.data?.html),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
