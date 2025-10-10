import 'package:flutter/material.dart';
import 'package:homepage_ui/configs/hp_layout.dart';

class HpContainerComponent extends StatelessWidget {
  final Widget? child;
  final Widget? title;
  final Color? color;
  final EdgeInsets? padding;

  const HpContainerComponent({super.key, this.child, this.title, this.color, this.padding});

  @override
  Widget build(BuildContext context) {
    Widget? finalTitle = title;
    return Container(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(HpLayout.containerDefaultBorderRadius),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(HpLayout.containerDefaultSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (finalTitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: HpLayout.containerDefaultSpacing),
                child: finalTitle,
              ),
            child ?? Container(),
          ],
        ),
      ),
    );
  }
}
