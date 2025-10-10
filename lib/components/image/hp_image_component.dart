import 'dart:typed_data';

import 'package:flutter/material.dart';

class HpImageComponent extends StatelessWidget {
  final double width;
  final double height;
  final Uint8List? data;
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;

  const HpImageComponent({
    super.key,
    this.data,
    this.isLoading = false,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? finalData = data;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(borderRadius: borderRadius, color: Theme.of(context).colorScheme.surfaceContainerHigh),
      child: !isLoading
          ? finalData != null
                ? ClipRRect(
                    borderRadius: borderRadius ?? BorderRadius.zero,
                    child: Image.memory(finalData, width: width, height: height),
                  )
                : Container()
          : Center(child: CircularProgressIndicator()),
    );
  }
}
