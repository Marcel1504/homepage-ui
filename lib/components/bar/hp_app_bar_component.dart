import 'package:flutter/material.dart';
import 'package:homepage_ui/configs/hp_layout.dart';

class HpAppBarComponent extends StatelessWidget {
  final List<Widget> actions;
  final String? title;
  final Widget? leading;

  const HpAppBarComponent({super.key, this.actions = const [], this.leading, this.title});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: HpLayout.appBarHeight, minHeight: HpLayout.appBarHeight),
      child: Row(
        children: [
          if (leading != null) _getLeading(context),
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(left: HpLayout.appBarSpacing),
              child: Text(title ?? "", style: Theme.of(context).textTheme.titleLarge),
            ),
          if (actions.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(HpLayout.appBarSpacing),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: actions),
              ),
            ),
        ],
      ),
    );
  }

  Widget _getLeading(BuildContext context) {
    return leading ?? Container();
  }
}
