import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_button_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';

class HpImageAssetButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final String imageAsset;
  final HpButtonType type;
  final double? height;
  final double? width;
  final EdgeInsets? padding;

  const HpImageAssetButtonComponent({
    super.key,
    this.onTap,
    required this.imageAsset,
    this.type = HpButtonType.normal,
    this.height,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return HpButtonComponent(
      height: height,
      width: width,
      type: type,
      onTap: onTap,
      builder: (context, foreground, background) => Padding(
        padding: padding ?? EdgeInsets.all((height ?? HpLayout.buttonDefaultSize) / 4),
        child: SizedBox(height: height, width: width, child: HpLayout.getImageAsset(context, imageAsset)),
      ),
    );
  }
}
