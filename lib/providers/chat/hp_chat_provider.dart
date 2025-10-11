import 'package:flutter/foundation.dart';
import 'package:homepage_ui/apis/chat/hp_chat_api.dart';
import 'package:homepage_ui/data/chat/hp_chat_data.dart';
import 'package:homepage_ui/data/error/hp_error_data.dart';
import 'package:homepage_ui/enums/hp_chat_message_type.dart';
import 'package:homepage_ui/exceptions/hp_exception.dart';
import 'package:homepage_ui/models/hp_chat_message_ui_model.dart';

class HpChatProvider extends ChangeNotifier {
  final HpChatApi _chatApi = HpChatApi();
  final List<HpChatMessageUiModel> _messages = [];
  int? _chatId;
  bool _isLoading = false;
  HpErrorData? _error;

  Future<void>? sendChatMessage(String? message) {
    if (message != null && !_isLoading) {
      _isLoading = true;
      _error = null;
      _messages.add(HpChatMessageUiModel(isUserMessage: true, type: HpChatMessageType.text, content: message));
      return Future.microtask(() async => await _postMessage(message));
    }
    return null;
  }

  void clearChat() {
    _messages.clear();
    _chatId = null;
    _error = null;
    _isLoading = false;
    Future.microtask(() => notifyListeners());
  }

  Future<void> _postMessage(String message) async {
    notifyListeners();
    try {
      HpChatData? data = await _chatApi.postChatMessage(message, chatId: _chatId);
      _chatId = data?.chatId;
      _messages.addAll(
        data?.messages?.map((m) => HpChatMessageUiModel(isUserMessage: false, type: m.type, content: m.content)) ?? [],
      );
    } on HpException catch (ex) {
      _error = ex.error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool get isLoading => _isLoading;

  List<HpChatMessageUiModel> get messages => _messages;

  HpErrorData? get error => _error;
}
