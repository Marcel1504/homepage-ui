import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:homepage_ui/components/container/hp_container_component.dart';
import 'package:homepage_ui/components/container/hp_timeline_container_component.dart';
import 'package:homepage_ui/components/scaffold/hp_main_scaffold_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/data/content/certifications/hp_content_certification_data.dart';
import 'package:homepage_ui/data/content/education/hp_content_education_data.dart';
import 'package:homepage_ui/data/content/jobs/hp_content_job_data.dart';
import 'package:homepage_ui/data/content/jobs/hp_content_job_role_data.dart';
import 'package:homepage_ui/data/content/jobs/hp_content_job_task_data.dart';
import 'package:homepage_ui/models/hp_content_model.dart';
import 'package:homepage_ui/models/hp_timeline_model.dart';
import 'package:homepage_ui/providers/content/hp_content_provider.dart';
import 'package:homepage_ui/services/content/loader/hp_content_certificates_loader_service.dart';
import 'package:homepage_ui/services/content/loader/hp_content_education_loader_service.dart';
import 'package:homepage_ui/services/content/loader/hp_content_jobs_loader_service.dart';
import 'package:homepage_ui/services/time/hp_time_service.dart';
import 'package:provider/provider.dart';

class HpProfilePage extends StatefulWidget {
  const HpProfilePage({super.key});

  @override
  State<HpProfilePage> createState() => _HpProfilePageState();
}

class _HpProfilePageState extends State<HpProfilePage> {
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
          return SingleChildScrollView(
            child: Column(
              children: [
                _getContentSectionHeader(context, HpI18n.translate(context, "content.jobs.header")),
                _getContentJobs(context, jobs),
                _getContentSectionHeader(context, HpI18n.translate(context, "content.education")),
                _getContentSectionHeader(context, HpI18n.translate(context, "content.certifications")),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getContentSectionHeader(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: HpLayout.containerDefaultSpacing),
      child: Text(text, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 25)),
    );
  }

  Widget _getContentJobs(BuildContext context, HpContentModel<List<HpContentJobData>> jobs) {
    List<HpContentJobData> list = jobs.data ?? [];
    return Column(children: list.mapIndexed((i, j) => _getContentJobsItem(context, j)).toList());
  }

  Widget _getContentJobsItem(BuildContext context, HpContentJobData job) {
    return HpContainerComponent(
      title: _getContentJobsItemHeader(context, job),
      child: Column(
        children: [
          _getContentJobsItemRoles(context, job),
          Padding(
            padding: const EdgeInsets.only(top: HpLayout.containerDefaultSpacing),
            child: _getContentJobsItemTasks(context, job),
          ),
        ],
      ),
    );
  }

  Widget _getContentJobsItemHeader(BuildContext context, HpContentJobData job) {
    return HpLayout.isMobile(context)
        ? _getContentJobsItemHeaderMobile(context, job)
        : _getContentJobsItemHeaderDesktop(context, job);
  }

  Widget _getContentJobsItemHeaderMobile(BuildContext context, HpContentJobData job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: HpLayout.containerDefaultSpacing / 2),
          child: Text(
            HpTimeService().transformMonthRangeString(context, job.dateFrom, job.dateTo),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.roles?.first.role ?? "", style: Theme.of(context).textTheme.titleLarge),
            Text(job.company ?? "", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }

  Widget _getContentJobsItemHeaderDesktop(BuildContext context, HpContentJobData job) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            HpTimeService().transformMonthRangeString(context, job.dateFrom, job.dateTo),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(job.roles?.first.role ?? "", style: Theme.of(context).textTheme.titleLarge),
              Text(job.company ?? "", style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getContentJobsItemRoles(BuildContext context, HpContentJobData job) {
    List<HpContentJobRoleData> roles = job.roles ?? [];
    return HpTimelineContainerComponent(
      title: HpI18n.translate(context, "content.jobs.roles"),
      timeline: roles.map((r) => HpTimelineModel(text: r.role, dateFrom: r.dateFrom, dateTo: r.dateTo)).toList(),
    );
  }

  Widget _getContentJobsItemTasks(BuildContext context, HpContentJobData job) {
    List<HpContentJobTaskData> tasks = job.tasks ?? [];
    return HpTimelineContainerComponent(
      title: HpI18n.translate(context, "content.jobs.tasks"),
      timeline: tasks.map((r) => HpTimelineModel(text: r.task, dateFrom: r.dateFrom, dateTo: r.dateTo)).toList(),
    );
  }
}
