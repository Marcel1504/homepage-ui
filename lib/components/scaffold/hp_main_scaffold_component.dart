import 'package:flutter/material.dart';
import 'package:homepage_ui/components/bar/hp_app_bar_component.dart';
import 'package:homepage_ui/components/bar/hp_footer_bar_component.dart';
import 'package:homepage_ui/components/button/hp_icon_text_button_component.dart';
import 'package:homepage_ui/components/button/hp_image_asset_button_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/configs/hp_router.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';
import 'package:homepage_ui/model/hp_action_model.dart';

class HpMainScaffoldComponent extends StatelessWidget {
  final Widget child;
  final String? activeActionText;

  const HpMainScaffoldComponent({super.key, required this.child, this.activeActionText});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = HpLayout.isMobile(context);
    return Scaffold(
      body: Column(
        children: [
          HpAppBarComponent(
            leading: HpImageAssetButtonComponent(
              imageAsset: "icon",
              onTap: () => HpRouter.push(HpRoute.main),
              type: HpButtonType.transparent,
              height: HpLayout.appBarHeight,
            ),
            actions: isMobile ? [] : _getDesktopNavigationActions(context),
          ),
          Expanded(child: child),
          HpFooterBarComponent(),
          if (isMobile) _getMobileNavigation(context),
        ],
      ),
    );
  }

  Widget _getMobileNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(HpLayout.buttonNavigationMobileSize / 2),
          topLeft: Radius.circular(HpLayout.buttonNavigationMobileSize / 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(HpLayout.appBarSpacing / 2),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: _getMobileNavigationActions(context)),
      ),
    );
  }

  List<Widget> _getDesktopNavigationActions(BuildContext context) {
    return _getNavigationActions(context)
        .map(
          (a) => Padding(
            padding: const EdgeInsets.only(left: HpLayout.appBarSpacing),
            child: HpIconTextButtonComponent(
              text: a.text,
              onTap: a.onTap,
              height: HpLayout.buttonAppBarSize,
              width: HpLayout.buttonAppBarSize * 4,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: HpLayout.buttonAppBarTextSize),
              type: activeActionText == a.text ? HpButtonType.primary : HpButtonType.normal,
            ),
          ),
        )
        .toList();
  }

  List<Widget> _getMobileNavigationActions(BuildContext context) {
    return _getNavigationActions(context)
        .map(
          (a) => HpIconTextButtonComponent(
            text: a.text,
            icon: a.icon,
            onTap: a.onTap,
            height: HpLayout.buttonNavigationMobileSize,
            width: HpLayout.buttonNavigationMobileSize * 2,
            textStyle: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: HpLayout.buttonNavigationMobileTextSize),
            iconSize: HpLayout.buttonNavigationMobileIconSize,
            type: activeActionText == a.text ? HpButtonType.glowing : HpButtonType.transparent,
            vertical: true,
          ),
        )
        .toList();
  }

  List<HpActionModel> _getNavigationActions(BuildContext context) {
    return [
      HpActionModel(
        text: HpI18n.translate(context, "pages.profile"),
        icon: Icons.person,
        onTap: () => HpRouter.push(HpRoute.profile),
      ),
      HpActionModel(
        text: HpI18n.translate(context, "pages.projects"),
        icon: Icons.work,
        onTap: () => HpRouter.push(HpRoute.projects),
      ),
      HpActionModel(
        text: HpI18n.translate(context, "pages.chat"),
        icon: Icons.chat,
        onTap: () => HpRouter.push(HpRoute.chat),
      ),
    ];
  }
}
