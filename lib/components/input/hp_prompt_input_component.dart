import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_icon_button_component.dart';
import 'package:homepage_ui/components/input/hp_input_component.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';

class HpPromptInputComponent extends StatefulWidget {
  final String? hint;
  final bool disabled;
  final Function(String)? onTextSent;
  final double size;

  const HpPromptInputComponent({
    super.key,
    this.hint,
    this.onTextSent,
    this.size = HpLayout.inputDefaultBaseSize,
    this.disabled = false,
  });

  @override
  State<HpPromptInputComponent> createState() => _HpPromptInputComponentState();
}

class _HpPromptInputComponentState extends State<HpPromptInputComponent> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _getTextField(context)),
        Padding(
          padding: EdgeInsets.only(left: widget.size * 0.2),
          child: _getSendButton(context),
        ),
      ],
    );
  }

  Widget _getTextField(BuildContext context) {
    return HpInputComponent(
      baseSize: widget.size,
      hint: widget.hint,
      enabled: !widget.disabled,
      keyboardType: TextInputType.text,
      controller: _controller,
      onInputChanged: (t) => setState(() {}),
    );
  }

  Widget _getSendButton(BuildContext context) {
    return HpIconButtonComponent(
      icon: Icons.send,
      height: widget.size,
      width: widget.size,
      onTap: !widget.disabled && _controller.text.isNotEmpty ? () => _onTextSent(context) : null,
      type: HpButtonType.primary,
    );
  }

  void _onTextSent(BuildContext context) {
    widget.onTextSent?.call(_controller.text.trim());
    setState(() => _controller.text = "");
  }
}
