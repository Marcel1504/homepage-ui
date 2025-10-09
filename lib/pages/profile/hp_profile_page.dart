import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_icon_text_button_component.dart';
import 'package:homepage_ui/components/scaffold/hp_main_scaffold_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/data/content/certifications/hp_content_certification_data.dart';
import 'package:homepage_ui/data/content/education/hp_content_education_data.dart';
import 'package:homepage_ui/data/content/jobs/hp_content_job_data.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';
import 'package:homepage_ui/models/hp_content_model.dart';
import 'package:homepage_ui/pages/profile/hp_profile_certifications_subpage.dart';
import 'package:homepage_ui/pages/profile/hp_profile_education_subpage.dart';
import 'package:homepage_ui/pages/profile/hp_profile_jobs_subpage.dart';
import 'package:homepage_ui/providers/content/hp_content_provider.dart';
import 'package:homepage_ui/services/content/loader/hp_content_certificates_loader_service.dart';
import 'package:homepage_ui/services/content/loader/hp_content_education_loader_service.dart';
import 'package:homepage_ui/services/content/loader/hp_content_jobs_loader_service.dart';
import 'package:provider/provider.dart';

class HpProfilePage extends StatefulWidget {
  const HpProfilePage({super.key});

  @override
  State<HpProfilePage> createState() => _HpProfilePageState();
}

class _HpProfilePageState extends State<HpProfilePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HpContentJobsLoaderService().load(context);
      HpContentEducationLoaderService().load(context);
      HpContentCertificationLoaderService().load(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return HpMainScaffoldComponent(
      activeActionText: HpI18n.translate(context, "pages.profile"),
      child: Consumer<HpContentProvider>(
        builder: (context, provider, _) {
          HpContentModel<List<HpContentJobData>> jobs = HpContentJobsLoaderService().get(context, provider);
          HpContentModel<List<HpContentEducationData>> education = HpContentEducationLoaderService().get(
            context,
            provider,
          );
          HpContentModel<List<HpContentCertificationData>> certifications = HpContentCertificationLoaderService().get(
            context,
            provider,
          );
          return jobs.isLoading || education.isLoading || certifications.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(children: [_getButtonRow(context), _getContent(context, jobs, education, certifications)]);
        },
      ),
    );
  }

  Widget _getButtonRow(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: HpLayout.pageMaxWidth),
      child: Align(
        alignment: AlignmentGeometry.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(HpLayout.pageDefaultSpacing),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HpI18n.translate(context, "content.jobs.header"),
                HpI18n.translate(context, "content.education"),
                HpI18n.translate(context, "content.certifications"),
              ].mapIndexed((i, s) => _getButtonRowItem(context, s, i)).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getButtonRowItem(BuildContext context, String text, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: HpLayout.pageDefaultSpacing * 0.5),
      child: HpIconTextButtonComponent(
        text: text,
        onTap: () => setState(() {
          _currentIndex = index;
          _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
        }),
        type: index == _currentIndex ? HpButtonType.primary : HpButtonType.normal,
      ),
    );
  }

  Widget _getContent(
    BuildContext context,
    HpContentModel<List<HpContentJobData>> jobs,
    HpContentModel<List<HpContentEducationData>> education,
    HpContentModel<List<HpContentCertificationData>> certifications,
  ) {
    return Expanded(
      child: PageView(
        controller: _pageController,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        children: _getContentItems(context, jobs, education, certifications)
            .map(
              (e) => Padding(
                padding: EdgeInsets.symmetric(horizontal: HpLayout.pageDefaultSpacing),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }

  List<Widget> _getContentItems(
    BuildContext context,
    HpContentModel<List<HpContentJobData>> jobs,
    HpContentModel<List<HpContentEducationData>> education,
    HpContentModel<List<HpContentCertificationData>> certifications,
  ) {
    return [
      HpProfileJobsSubpage(jobs: jobs.data ?? []),
      HpProfileEducationSubpage(education: education.data ?? []),
      HpProfileCertificationsSubpage(certifications: certifications.data ?? []),
    ];
  }
}
