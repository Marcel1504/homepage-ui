import 'package:flutter/material.dart';
import 'package:homepage_ui/configs/hp_layout.dart';

class HpInputComponent extends StatelessWidget {
  static const double mBorderRadius = 0.35;
  static const double mSpacingVertical = 0.3;
  static const double mSpacingHorizontal = 0.3;
  static const double mFontSizeHint = 0.4;
  static const double mFontSizeInput = 0.4;
  static const double mFontSizeLabel = 0.4;

  final TextEditingController? controller;
  final Function(String)? onInputChanged;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? hint;
  final String? label;
  final int? inputMaxLines;
  final String? Function(String?)? validator;
  final bool autofocus;
  final bool enabled;
  final double baseSize;

  const HpInputComponent({
    super.key,
    this.baseSize = HpLayout.inputDefaultBaseSize,
    this.onInputChanged,
    this.keyboardType = TextInputType.text,
    this.inputMaxLines,
    this.hint,
    this.controller,
    this.textInputAction = TextInputAction.none,
    this.autofocus = false,
    this.label,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return _form(context, false);
  }

  Widget _form(BuildContext context, bool hasLabel) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        autofocus: autofocus,
        maxLines: inputMaxLines,
        textInputAction: textInputAction,
        onChanged: (t) => onInputChanged?.call(t),
        validator: validator,
        enabled: enabled,
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: baseSize * mFontSizeInput,
        ),
        decoration: _formTextFieldDecoration(context, hasLabel),
      ),
    );
  }

  InputDecoration _formTextFieldDecoration(BuildContext context, bool hasLabel) {
    return InputDecoration(
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
      errorBorder: _formErrorBorder(context),
      focusedErrorBorder: _formErrorBorder(context),
      enabledBorder: _formNormalBorder(context),
      focusedBorder: _formFocusedBorder(context),
      disabledBorder: _formNormalBorder(context),
      errorStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.error),
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      floatingLabelStyle: _labelStyle(context),
      hintText: hint,
      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: baseSize * mFontSizeHint,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(191),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: baseSize * mSpacingHorizontal,
        vertical: baseSize * mSpacingVertical,
      ),
    );
  }

  InputBorder _formErrorBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: HpLayout.inputDefaultBorderWidth, color: Theme.of(context).colorScheme.error),
      borderRadius: BorderRadius.circular(baseSize * mBorderRadius),
    );
  }

  InputBorder _formNormalBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: HpLayout.inputDefaultBorderWidth,
        color: Theme.of(context).colorScheme.primary.withAlpha(50),
      ),
      borderRadius: BorderRadius.circular(baseSize * mBorderRadius),
    );
  }

  InputBorder _formFocusedBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: HpLayout.inputDefaultBorderWidth, color: Theme.of(context).colorScheme.primary),
      borderRadius: BorderRadius.circular(baseSize * mBorderRadius),
    );
  }

  WidgetStateTextStyle _labelStyle(BuildContext context) {
    return WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
      Color color = Theme.of(context).colorScheme.onSurface;
      if (states.contains(WidgetState.error)) {
        color = Theme.of(context).colorScheme.error;
      } else if (states.contains(WidgetState.focused)) {
        color = Theme.of(context).colorScheme.primary;
      }
      return Theme.of(context).textTheme.bodyMedium!.copyWith(color: color, fontSize: baseSize * mFontSizeLabel);
    });
  }
}
