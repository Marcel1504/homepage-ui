import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_icon_button_component.dart';
import 'package:homepage_ui/components/scaffold/hp_main_scaffold_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';

class HpMainPage extends StatelessWidget {
  const HpMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = HpLayout.isMobile(context);
    return HpMainScaffoldComponent(
      child: Center(
        child: isMobile
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_getImage(context), _getContent(context, true)],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_getImage(context), _getContent(context, false)],
              ),
      ),
    );
  }

  Widget _getImage(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(250 / 2),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
    );
  }

  Widget _getContent(BuildContext context, bool isMobile) {
    return Padding(
      padding: EdgeInsets.only(
        left: isMobile ? 0 : HpLayout.pageDefaultSpacing,
        top: isMobile ? HpLayout.pageDefaultSpacing : 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [_getContentHeader(context), _getContentSocialLinks(context)],
      ),
    );
  }

  Widget _getContentHeader(BuildContext context) {
    return Column(
      children: [
        Text("", style: Theme.of(context).textTheme.titleLarge),
        Text(""),
      ],
    );
  }

  Widget _getContentSocialLinks(BuildContext context) {
    List<Widget> links = _getContentSocialLinksButtons(context);
    return Padding(
      padding: const EdgeInsets.only(top: HpLayout.pageDefaultSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: links
            .mapIndexed(
              (i, e) => Padding(
                padding: EdgeInsets.only(right: i < links.length - 1 ? HpLayout.pageDefaultSpacing : 0),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }

  List<Widget> _getContentSocialLinksButtons(BuildContext context) {
    return [
      // TODO: set button sizes
      HpIconButtonComponent(icon: Icons.youtube_searched_for, onTap: () {}, height: 50, width: 50),
      HpIconButtonComponent(icon: Icons.youtube_searched_for, onTap: () {}, height: 50, width: 50),
      HpIconButtonComponent(icon: Icons.youtube_searched_for, onTap: () {}, height: 50, width: 50),
      HpIconButtonComponent(icon: Icons.youtube_searched_for, onTap: () {}, height: 50, width: 50),
      HpIconButtonComponent(icon: Icons.youtube_searched_for, onTap: () {}, height: 50, width: 50),
    ];
  }
}
