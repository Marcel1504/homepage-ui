import 'dart:typed_data';

import 'package:flutter/material.dart';

class HpRoundImageComponent extends StatelessWidget {
  final double size;
  final Uint8List? data;
  final bool isLoading;

  const HpRoundImageComponent({super.key, required this.size, this.data, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    Uint8List? finalData = data;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: !isLoading
          ? finalData != null
                ? ClipOval(
                    child: Image.memory(finalData, width: size, height: size),
                  )
                : Container()
          : Center(child: CircularProgressIndicator()),
    );
  }
}
