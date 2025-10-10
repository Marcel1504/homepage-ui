import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_icon_button_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';

class HpDialogComponent extends StatelessWidget {
  final String? text;

  const HpDialogComponent({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(HpLayout.containerDefaultBorderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.all(HpLayout.containerDefaultSpacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: SingleChildScrollView(child: Text(text ?? "", style: Theme.of(context).textTheme.titleMedium)),
              ),
              _getCloseAction(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCloseAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: HpLayout.containerDefaultSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          HpIconButtonComponent(
            onTap: () => Navigator.of(context).pop(),
            icon: Icons.close,
            height: HpLayout.buttonDefaultSize,
            width: HpLayout.buttonDefaultSize,
          ),
        ],
      ),
    );
  }
}
