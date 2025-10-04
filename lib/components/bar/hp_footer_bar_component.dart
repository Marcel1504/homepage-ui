import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_icon_text_button_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/configs/hp_router.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';

class HpFooterBarComponent extends StatelessWidget {
  const HpFooterBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: HpLayout.buttonFooterTextSize);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(HpLayout.pageDefaultSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: HpLayout.buttonFooterSize / 4),
              child: Text(HpI18n.translate(context, "footer.copyright"), style: textStyle),
            ),
            Text("|", style: textStyle),
            HpIconTextButtonComponent(
              text: HpI18n.translate(context, "pages.legalImprint"),
              onTap: () => HpRouter.push(HpRoute.legalImprint),
              height: HpLayout.buttonFooterSize,
              textStyle: textStyle,
              type: HpButtonType.transparent,
            ),
            Text("|", style: textStyle),
            HpIconTextButtonComponent(
              text: HpI18n.translate(context, "pages.legalPrivacyPolicy"),
              onTap: () => HpRouter.push(HpRoute.legalPrivacyPolicy),
              height: HpLayout.buttonFooterSize,
              textStyle: textStyle,
              type: HpButtonType.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
