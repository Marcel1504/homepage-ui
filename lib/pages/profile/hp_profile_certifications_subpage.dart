import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:homepage_ui/components/container/hp_container_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/data/content/certifications/hp_content_certification_data.dart';
import 'package:homepage_ui/services/time/hp_time_service.dart';

class HpProfileCertificationsSubpage extends StatelessWidget {
  final List<HpContentCertificationData> certifications;

  const HpProfileCertificationsSubpage({super.key, required this.certifications});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: HpLayout.pageMaxWidth),
          child: Column(
            children: certifications.mapIndexed((i, e) => _getContentCertificationsItem(context, e)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _getContentCertificationsItem(BuildContext context, HpContentCertificationData cert) {
    return Padding(
      padding: const EdgeInsets.only(top: HpLayout.pageDefaultSpacing),
      child: HpContainerComponent(
        title: _getContentCertificationsItemHeader(context, cert.dateFrom, cert.dateTo, cert.title),
        child: _getContentCertificationsBody(context, cert.description ?? ""),
      ),
    );
  }

  Widget _getContentCertificationsItemHeader(BuildContext context, String? dateFrom, String? dateTo, String? title) {
    return HpLayout.isMobile(context)
        ? _getContentCertificationsItemHeaderMobile(context, dateFrom, dateTo, title)
        : _getContentCertificationsItemHeaderDesktop(context, dateFrom, dateTo, title);
  }

  Widget _getContentCertificationsItemHeaderMobile(
    BuildContext context,
    String? dateFrom,
    String? dateTo,
    String? title,
  ) {
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

  Widget _getContentCertificationsItemHeaderDesktop(
    BuildContext context,
    String? dateFrom,
    String? dateTo,
    String? title,
  ) {
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

  Widget _getContentCertificationsBody(BuildContext context, String bodyText) {
    return HpContainerComponent(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Row(
        children: [Flexible(child: Text(bodyText, style: Theme.of(context).textTheme.headlineMedium))],
      ),
    );
  }
}
