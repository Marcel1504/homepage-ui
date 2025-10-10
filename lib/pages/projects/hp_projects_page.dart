import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_icon_button_component.dart';
import 'package:homepage_ui/components/container/hp_container_component.dart';
import 'package:homepage_ui/components/dialog/hp_dialog_component.dart';
import 'package:homepage_ui/components/image/hp_image_component.dart';
import 'package:homepage_ui/components/scaffold/hp_main_scaffold_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/data/content/projects/hp_content_project_data.dart';
import 'package:homepage_ui/data/media/hp_media_data.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';
import 'package:homepage_ui/models/hp_content_model.dart';
import 'package:homepage_ui/providers/content/hp_content_provider.dart';
import 'package:homepage_ui/providers/media/hp_media_provider.dart';
import 'package:homepage_ui/services/content/loader/hp_content_projects_loader_service.dart';
import 'package:homepage_ui/services/time/hp_time_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HpProjectsPage extends StatefulWidget {
  const HpProjectsPage({super.key});

  @override
  State<HpProjectsPage> createState() => _HpProjectsPageState();
}

class _HpProjectsPageState extends State<HpProjectsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HpContentProjectsLoaderService().load(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return HpMainScaffoldComponent(
      activeActionText: HpI18n.translate(context, "pages.projects"),
      child: Consumer<HpContentProvider>(
        builder: (context, provider, _) {
          HpContentModel<List<HpContentProjectData>> projects = HpContentProjectsLoaderService().get(context, provider);
          return projects.isLoading
              ? Center(child: CircularProgressIndicator())
              : _getProjects(context, projects.data ?? []);
        },
      ),
    );
  }

  Widget _getProjects(BuildContext context, List<HpContentProjectData> projects) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: HpLayout.pageDefaultSpacing),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: HpLayout.pageMaxWidth),
            child: Column(children: projects.map((p) => _getProjectItem(context, p)).toList()),
          ),
        ),
      ),
    );
  }

  Widget _getProjectItem(BuildContext context, HpContentProjectData project) {
    return Consumer<HpMediaProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.only(top: HpLayout.pageDefaultSpacing),
          child: HpContainerComponent(
            padding: EdgeInsets.zero,
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _getProjectItemImage(context, provider.mediaCache[project.thumbnailMedia]),
                  _getProjectItemInfo(context, project),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getProjectItemImage(BuildContext context, HpMediaData? media) {
    Uint8List? thumbnail = media?.data;
    bool isLoading = media?.loading ?? true;
    return HpImageComponent(
      height: HpLayout.imageProjectsSize,
      width: HpLayout.imageProjectsSize,
      data: thumbnail,
      isLoading: isLoading,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(HpLayout.containerDefaultBorderRadius),
        bottomLeft: Radius.circular(HpLayout.containerDefaultBorderRadius),
      ),
    );
  }

  Widget _getProjectItemInfo(BuildContext context, HpContentProjectData project) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(HpLayout.containerDefaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.title ?? "", style: Theme.of(context).textTheme.titleLarge, maxLines: 2),
            Expanded(
              child: Text(
                HpTimeService().transformMonthRangeString(context, project.dateFrom, project.dateTo),
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
            ),
            _getProjectItemButtons(context, project),
          ],
        ),
      ),
    );
  }

  Widget _getProjectItemButtons(BuildContext context, HpContentProjectData project) {
    String? link = project.externalLink;
    String? description = project.description;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (description != null)
          HpIconButtonComponent(
            icon: Icons.info,
            onTap: () => _showProjectInfoDialog(context, description),
            height: HpLayout.buttonDefaultSize,
            width: HpLayout.buttonDefaultSize,
            type: HpButtonType.glowing,
          ),
        if (link != null)
          Padding(
            padding: const EdgeInsets.only(left: HpLayout.containerDefaultSpacing * 0.5),
            child: HpIconButtonComponent(
              icon: Icons.open_in_new,
              onTap: () => launchUrl(Uri.parse(link)),
              height: HpLayout.buttonDefaultSize,
              width: HpLayout.buttonDefaultSize,
              type: HpButtonType.glowing,
            ),
          ),
      ],
    );
  }

  void _showProjectInfoDialog(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (context) => HpDialogComponent(text: description),
    );
  }
}
