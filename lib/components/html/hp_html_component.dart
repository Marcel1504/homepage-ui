import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HpHtmlComponent extends StatelessWidget {
  final String? data;

  const HpHtmlComponent({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    TextStyle h1 = Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24);
    TextStyle h2 = Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 21);
    TextStyle p = Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18);
    return Html(style: {"h1": _getStyle(h1, 24), "h2": _getStyle(h2, 20), "p": _getStyle(p, 10)}, data: data ?? "");
  }

  Style _getStyle(TextStyle textStyle, double margin) {
    return Style(
      margin: Margins(bottom: Margin(0), top: Margin(margin)),
      color: textStyle.color,
      fontSize: FontSize(textStyle.fontSize!),
      fontWeight: textStyle.fontWeight,
      fontFamily: textStyle.fontFamily,
      fontStyle: textStyle.fontStyle,
    );
  }
}
