import 'package:flutter/material.dart';
import 'package:homepage_ui/configs/hp_layout.dart';

class HpChatMessageComponent extends StatelessWidget {
  final String? text;
  final bool isUserMessage;
  final double width;

  const HpChatMessageComponent({super.key, this.text, required this.width, this.isUserMessage = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width * 0.9),
          child: Container(
            decoration: _getBoxDecoration(context),
            child: Padding(
              padding: const EdgeInsets.all(HpLayout.containerDefaultSpacing),
              child: _getContent(context),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _getBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: isUserMessage ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.only(
        bottomLeft: const Radius.circular(HpLayout.containerDefaultBorderRadius),
        bottomRight: const Radius.circular(HpLayout.containerDefaultBorderRadius),
        topLeft: Radius.circular(isUserMessage ? HpLayout.containerDefaultBorderRadius : 0),
        topRight: Radius.circular(isUserMessage ? 0 : HpLayout.containerDefaultBorderRadius),
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    return Text(
      text ?? "",
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: isUserMessage ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
