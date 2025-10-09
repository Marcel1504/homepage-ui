import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/models/hp_timeline_model.dart';
import 'package:homepage_ui/services/time/hp_time_service.dart';

class HpTimelineContainerComponent extends StatelessWidget {
  final String? title;
  final List<HpTimelineModel>? timeline;
  final Color? color;

  const HpTimelineContainerComponent({super.key, this.title, this.timeline = const [], this.color});

  @override
  Widget build(BuildContext context) {
    String? finalTitle = title;
    return Container(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(HpLayout.containerDefaultBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(HpLayout.containerDefaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [if (finalTitle != null) _getTitle(context, finalTitle), _getTimeline(context)],
        ),
      ),
    );
  }

  Widget _getTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: HpLayout.containerDefaultSpacing),
      child: Row(children: [Text(title, style: Theme.of(context).textTheme.headlineLarge)]),
    );
  }

  Widget _getTimeline(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: (timeline ?? [])
          .mapIndexed(
            (i, t) => Padding(
              padding: EdgeInsets.only(top: i != 0 ? HpLayout.containerDefaultSpacing : 0),
              child: HpLayout.isMobile(context) ? _getTimelineMobile(context, t) : _getTimelineDesktop(context, t),
            ),
          )
          .toList(),
    );
  }

  Widget _getTimelineMobile(BuildContext context, HpTimelineModel t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          HpTimeService().transformMonthRangeString(context, t.dateFrom, t.dateTo),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(t.text ?? "", style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }

  Widget _getTimelineDesktop(BuildContext context, HpTimelineModel t) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            HpTimeService().transformMonthRangeString(context, t.dateFrom, t.dateTo),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(flex: 3, child: Text(t.text ?? "", style: Theme.of(context).textTheme.headlineMedium)),
      ],
    );
  }
}
