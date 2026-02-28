import 'package:flutter/material.dart';
import 'package:homepage_ui/components/button/hp_icon_text_button_component.dart';
import 'package:homepage_ui/components/chat/hp_chat_message_component.dart';
import 'package:homepage_ui/components/container/hp_container_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/data/error/hp_error_data.dart';
import 'package:homepage_ui/enums/hp_button_type.dart';
import 'package:homepage_ui/models/hp_chat_message_ui_model.dart';
import 'package:homepage_ui/services/error/hp_error_service.dart';

class HpChatComponent extends StatelessWidget {
  final List<HpChatMessageUiModel> messages;
  final bool isLoading;
  final bool hasConsent;
  final HpErrorData? error;
  final Function()? onReset;
  final Function()? onConsent;

  const HpChatComponent({
    super.key,
    this.messages = const [],
    this.isLoading = false,
    this.onReset,
    this.error,
    this.onConsent,
    this.hasConsent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (hasConsent)
          LayoutBuilder(
            builder: (context, constraints) {
              return ListView(
                shrinkWrap: true,
                children: messages.map((e) => _getChatMessage(context, constraints.maxWidth, e)).toList(),
              );
            },
          ),
        if (!hasConsent) _getConsentDisclaimer(context),
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

  Widget _getConsentDisclaimer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: HpLayout.pageDefaultSpacing),
      child: HpContainerComponent(
        title: Text(HpI18n.translate(context, "chat.consent.title"), style: Theme.of(context).textTheme.titleLarge),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: HpLayout.containerDefaultSpacing),
              child: Text(
                HpI18n.translate(context, "chat.consent.text"),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            HpIconTextButtonComponent(
              text: HpI18n.translate(context, "action.consent"),
              onTap: () => onConsent?.call(),
              type: HpButtonType.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getChatMessage(BuildContext context, double maxWidth, HpChatMessageUiModel chatMessage) {
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
