import 'package:flutter/material.dart';
import 'package:homepage_ui/components/material/hp_material_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';

class HpButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final HpButtonType type;
  final double? height;
  final double? width;
  final Widget Function(BuildContext context, Color foreground, Color background) builder;

  const HpButtonComponent({
    super.key,
    this.onTap,
    this.type = HpButtonType.normal,
    this.height,
    required this.builder,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    Color background = _getBackgroundColor(context);
    Color foreground = _getForegroundColor(context);
    return HpMaterialComponent(
      backgroundColor: background,
      height: height ?? HpLayout.buttonDefaultSize,
      width: width,
      onTap: onTap,
      borderRadius: BorderRadius.circular(height ?? HpLayout.buttonDefaultSize / 2),
      child: builder.call(context, foreground, background),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    Color color;
    switch (type) {
      case HpButtonType.primary:
        color = Theme.of(context).colorScheme.primary;
        break;
      case HpButtonType.normal:
        color = Theme.of(context).colorScheme.surfaceContainerHigh;
        break;
      case HpButtonType.glowing:
        color = Theme.of(context).colorScheme.primary.withAlpha(30);
        break;
      case HpButtonType.transparent:
        color = Colors.transparent;
    }
    return onTap != null ? color : color.withAlpha(20);
  }

  Color _getForegroundColor(BuildContext context) {
    Color color;
    switch (type) {
      case HpButtonType.primary:
        color = Theme.of(context).colorScheme.onPrimary;
        break;
      case HpButtonType.normal:
        color = Theme.of(context).colorScheme.onSurface;
        break;
      case HpButtonType.glowing:
        color = Theme.of(context).colorScheme.primary;
        break;
      case HpButtonType.transparent:
        color = Theme.of(context).colorScheme.onSurface;
    }
    return onTap != null ? color : color.withAlpha(20);
  }
}
