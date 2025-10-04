import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_button_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';

class HpIconButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final HpButtonType type;
  final double? height;
  final double? width;

  const HpIconButtonComponent({
    super.key,
    this.icon,
    this.onTap,
    this.type = HpButtonType.normal,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return HpButtonComponent(
      height: height,
      width: width,
      type: type,
      onTap: onTap,
      builder: (context, foreground, background) =>
          Icon(icon, color: foreground, size: (height ?? HpLayout.buttonDefaultSize) / 2),
    );
  }
}
