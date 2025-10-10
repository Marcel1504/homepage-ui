import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:homepage_ui/components/container/hp_container_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/data/content/education/hp_content_education_data.dart';
import 'package:homepage_ui/services/time/hp_time_service.dart';

class HpProfileEducationSubpage extends StatelessWidget {
  final List<HpContentEducationData> education;

  const HpProfileEducationSubpage({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: HpLayout.pageMaxWidth),
          child: Column(children: education.mapIndexed((i, e) => _getContentEducationItem(context, e)).toList()),
        ),
      ),
    );
  }

  Widget _getContentEducationItem(BuildContext context, HpContentEducationData education) {
    return Padding(
      padding: const EdgeInsets.only(top: HpLayout.pageDefaultSpacing),
      child: HpContainerComponent(
        title: _getContentEducationItemHeader(context, education.dateFrom, education.dateTo, education.institute),
        child: _getContentEducationBody(context, education.degree ?? "?"),
      ),
    );
  }

  Widget _getContentEducationItemHeader(BuildContext context, String? dateFrom, String? dateTo, String? title) {
    return HpLayout.isMobile(context)
        ? _getContentEducationItemHeaderMobile(context, dateFrom, dateTo, title)
        : _getContentEducationItemHeaderDesktop(context, dateFrom, dateTo, title);
  }

  Widget _getContentEducationItemHeaderMobile(BuildContext context, String? dateFrom, String? dateTo, String? title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: HpLayout.containerDefaultSpacing / 2),
          child: Text(
            HpTimeService().transformMonthRangeString(context, dateFrom, dateTo),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Text(title ?? "", style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }

  Widget _getContentEducationItemHeaderDesktop(BuildContext context, String? dateFrom, String? dateTo, String? title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          HpTimeService().transformMonthRangeString(context, dateFrom, dateTo),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Expanded(
          child: Text(title ?? "", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.end),
        ),
      ],
    );
  }

  Widget _getContentEducationBody(BuildContext context, String bodyText) {
    return HpContainerComponent(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Row(
        children: [Flexible(child: Text(bodyText, style: Theme.of(context).textTheme.headlineMedium))],
      ),
    );
  }
}
