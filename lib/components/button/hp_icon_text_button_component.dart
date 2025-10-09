import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_button_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';

class HpIconTextButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final String? text;
  final HpButtonType type;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final double iconSize;
  final bool vertical;

  const HpIconTextButtonComponent({
    super.key,
    this.onTap,
    this.icon,
    this.text,
    this.type = HpButtonType.normal,
    this.vertical = false,
    this.height,
    this.width,
    this.iconSize = HpLayout.buttonDefaultIconSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return HpButtonComponent(
      height: height,
      width: width,
      type: type,
      onTap: onTap,
      builder: (context, foreground, background) => Padding(
        padding: EdgeInsets.symmetric(horizontal: (height ?? HpLayout.buttonDefaultSize) / 4),
        child: vertical
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [if (icon != null) _getIcon(context, foreground), _getText(context, foreground)],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [if (icon != null) _getIcon(context, foreground), _getText(context, foreground)],
              ),
      ),
    );
  }

  Widget _getIcon(BuildContext context, Color foreground) {
    return Icon(icon, color: foreground, size: iconSize);
  }

  Widget _getText(BuildContext context, Color foreground) {
    TextStyle finalTextStyle =
        textStyle ?? Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: HpLayout.buttonDefaultTextSize);
    return Padding(
      padding: EdgeInsets.only(left: icon != null && !vertical ? (height ?? HpLayout.buttonDefaultSize) / 6 : 0),
      child: Text(text ?? "", style: finalTextStyle.copyWith(color: foreground)),
    );
  }
}
