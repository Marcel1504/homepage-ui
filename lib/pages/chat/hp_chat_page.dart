import 'package:flutter/material.dart';
import 'package:homepage_ui/components/chat/hp_chat_component.dart';
import 'package:homepage_ui/components/input/hp_prompt_input_component.dart';
import 'package:homepage_ui/components/scaffold/hp_main_scaffold_component.dart';
import 'package:homepage_ui/configs/hp_i18n.dart';
import 'package:homepage_ui/configs/hp_layout.dart';
import 'package:homepage_ui/providers/chat/hp_chat_provider.dart';
import 'package:provider/provider.dart';

class HpChatPage extends StatefulWidget {
  const HpChatPage({super.key});

  @override
  State<HpChatPage> createState() => _HpChatPageState();
}

class _HpChatPageState extends State<HpChatPage> {
  late final ScrollController _scrollController;
  int _currentMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return HpMainScaffoldComponent(
      activeActionText: HpI18n.translate(context, "pages.chat"),
      child: Consumer<HpChatProvider>(
        builder: (context, provider, _) {
          int newMessageCount = provider.messages.length;
          if (newMessageCount > _currentMessageCount) {
            Future.microtask(
                  () => setState(() => _scrollController.jumpTo(_scrollController.position.maxScrollExtent)),
            );
          }
          _currentMessageCount = newMessageCount;
          return Column(children: [_getChatMessagesList(context, provider), _getChatInput(context, provider)]);
        },
      ),
    );
  }

  Widget _getChatMessagesList(BuildContext context, HpChatProvider provider) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: HpLayout.pageDefaultSpacing),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: HpLayout.pageMaxWidth),
                child: HpChatComponent(
                  hasConsent: provider.hasConsent,
                  messages: provider.messages,
                  isLoading: provider.isLoading,
                  error: provider.error,
                  onReset: () => provider.clearChat(),
                  onConsent: () => provider.consent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getChatInput(BuildContext context, HpChatProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(
        top: HpLayout.pageDefaultSpacing,
        left: HpLayout.pageDefaultSpacing,
        right: HpLayout.pageDefaultSpacing,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: HpLayout.pageMaxWidth),
        child: Opacity(
          opacity: provider.hasConsent ? 1 : 0.1,
          child: HpPromptInputComponent(
            disabled: !provider.hasConsent || provider.isLoading || provider.error != null,
            onTextSent: (t) => provider.sendChatMessage(t),
            hint: HpI18n.translate(context, "chat.question"),
          ),
        ),
      ),
    );
  }
}
