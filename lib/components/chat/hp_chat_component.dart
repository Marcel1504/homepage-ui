import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_icon_text_button_component.dart';
import 'package:homepage_ui/components/chat/hp_chat_message_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/data/error/hp_error_data.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';
import 'package:homepage_ui/models/hp_chat_message_ui_model.dart';
import 'package:homepage_ui/services/error/hp_error_service.dart';

class HpChatComponent extends StatelessWidget {
  final List<HpChatMessageUiModel> messages;
  final bool isLoading;
  final HpErrorData? error;
  final Function()? onReset;

  const HpChatComponent({super.key, this.messages = const [], this.isLoading = false, this.onReset, this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              shrinkWrap: true,
              children: messages.map((e) => _chatMessage(context, constraints.maxWidth, e)).toList(),
            );
          },
        ),
        if (isLoading) _loading(context),
        if (!isLoading && error != null) _error(context),
      ],
    );
  }

  Widget _loading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: HpLayout.pageDefaultSpacing),
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(BuildContext context) {
    return Column(
      children: [
        Text(
          HpErrorService().createMessage(context, error),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.error),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: HpLayout.pageDefaultSpacing),
          child: HpIconTextButtonComponent(
            type: HpButtonType.normal,
            text: HpI18n.translate(context, "action.reset"),
            onTap: onReset,
            icon: Icons.refresh,
          ),
        ),
      ],
    );
  }

  Widget _chatMessage(BuildContext context, double maxWidth, HpChatMessageUiModel chatMessage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: HpLayout.pageDefaultSpacing),
      child: HpChatMessageComponent(
        width: maxWidth,
        isUserMessage: chatMessage.isUserMessage,
        text: chatMessage.content,
      ),
    );
  }
}
