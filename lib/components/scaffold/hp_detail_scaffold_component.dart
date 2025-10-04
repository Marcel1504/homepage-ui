import 'package:flutter/material.dart';
import 'package:homepage_ui/components/bar/hp_app_bar_component.dart';
import 'package:homepage_ui/components/bar/hp_footer_bar_component.dart';
import 'package:homepage_ui/components/button/hp_icon_button_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/configs/hp_router.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';

class HpDetailScaffoldComponent extends StatelessWidget {
  final Widget child;
  final String? title;

  const HpDetailScaffoldComponent({super.key, required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HpAppBarComponent(
            title: title,
            leading: HpIconButtonComponent(
              icon: Icons.arrow_back,
              type: HpButtonType.transparent,
              width: HpLayout.appBarHeight,
              height: HpLayout.appBarHeight,
              onTap: () => HpRouter.pop(defaultRoute: HpRoute.main),
            ),
          ),
          Expanded(child: child),
          HpFooterBarComponent(),
        ],
      ),
    );
  }
}
