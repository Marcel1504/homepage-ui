import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:homepage_ui/components/container/hp_container_component.dart';
import 'package:homepage_ui/components/container/hp_timeline_container_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/data/content/jobs/hp_content_job_data.dart';
import 'package:homepage_ui/data/content/jobs/hp_content_job_role_data.dart';
import 'package:homepage_ui/data/content/jobs/hp_content_job_task_data.dart';
import 'package:homepage_ui/models/hp_timeline_model.dart';
import 'package:homepage_ui/services/time/hp_time_service.dart';

class HpProfileJobsSubpage extends StatelessWidget {
  final List<HpContentJobData> jobs;

  const HpProfileJobsSubpage({super.key, this.jobs = const []});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: HpLayout.pageMaxWidth),
          child: Column(children: jobs.mapIndexed((i, j) => _getContentJobsItem(context, j)).toList()),
        ),
      ),
    );
  }

  Widget _getContentJobsItem(BuildContext context, HpContentJobData job) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: HpLayout.pageDefaultSpacing),
      child: HpContainerComponent(
        title: _getContentJobsItemHeader(context, job),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        child: Column(
          children: [
            _getContentJobsItemRoles(context, job),
            Padding(
              padding: const EdgeInsets.only(top: HpLayout.containerDefaultSpacing),
              child: _getContentJobsItemTasks(context, job),
            ),
          ],
        ),
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
            Text(job.company ?? "", style: Theme.of(context).textTheme.titleSmall),
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
        Text(
          HpTimeService().transformMonthRangeString(context, job.dateFrom, job.dateTo),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(job.roles?.first.role ?? "", style: Theme.of(context).textTheme.titleLarge),
            Text(job.company ?? "", style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ],
    );
  }

  Widget _getContentJobsItemRoles(BuildContext context, HpContentJobData job) {
    List<HpContentJobRoleData> roles = job.roles ?? [];
    return HpTimelineContainerComponent(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      title: HpI18n.translate(context, "content.jobs.roles"),
      timeline: roles.map((r) => HpTimelineModel(text: r.role, dateFrom: r.dateFrom, dateTo: r.dateTo)).toList(),
    );
  }

  Widget _getContentJobsItemTasks(BuildContext context, HpContentJobData job) {
    List<HpContentJobTaskData> tasks = job.tasks ?? [];
    return HpTimelineContainerComponent(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      title: HpI18n.translate(context, "content.jobs.tasks"),
      timeline: tasks.map((r) => HpTimelineModel(text: r.task, dateFrom: r.dateFrom, dateTo: r.dateTo)).toList(),
    );
  }
}
