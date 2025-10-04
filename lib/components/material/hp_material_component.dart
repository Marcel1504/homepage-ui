import 'package:flutter/material.dart';

class HpMaterialComponent extends StatelessWidget {
  final Color? backgroundColor;
  final Color? splashColor;
  final GestureTapCallback? onTap;
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius? borderRadius;

  const HpMaterialComponent({
    super.key,
    this.backgroundColor,
    this.onTap,
    this.width,
    this.height,
    this.child,
    this.splashColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        borderRadius: borderRadius,
        child: SizedBox(height: height, width: width, child: child),
      ),
    );
  }
}
