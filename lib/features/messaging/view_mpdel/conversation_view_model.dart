import 'package:flutter/cupertino.dart';
import 'package:jobxprss_company/features/messaging/model/conversation_screen_data_model.dart';
export 'package:jobxprss_company/features/messaging/model/conversation_screen_data_model.dart';
import 'package:jobxprss_company/features/messaging/repositories/message_repository.dart';
export 'package:jobxprss_company/features/messaging/repositories/message_repository.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
export 'package:jobxprss_company/main_app/failure/app_error.dart';

class ConversationViewModel with ChangeNotifier {
//  String senderId;
  List<Message> _messages = [];
  AppError _appError;
  bool _isFetchingData = false;
  bool _isGettingMoreData = false;
  bool _hasMoreData = false;
  bool _sendingMessage = false;
  int pageCount = 1;

  refresh(String senderId) {
    pageCount = 1;
    _hasMoreData = false;
    return getConversation(senderId);
  }

  Future<void> getConversation(String senderId) async {
    _isFetchingData = true;
    notifyListeners();
    var res = await MessageRepository().getConversation(senderId);
    res.fold((l) {
      _isFetchingData = false;
      _hasMoreData = false;
      _appError = l;
      notifyListeners();
    }, (r) {
      _isFetchingData = false;
      _messages = r.messages ?? [];
      _hasMoreData = r.pages.nextUrl;
      notifyListeners();
    });
  }

  getMoreData(String senderId) async {
    if (_hasMoreData && !isGettingMoreData) {
      pageCount++;
      _isGettingMoreData = true;
      notifyListeners();
      var res =
          await MessageRepository().getConversation(senderId, page: pageCount);
      res.fold((l) {
        _isGettingMoreData = false;
        _appError = l;
        _hasMoreData = false;
        notifyListeners();
      }, (r) {
        _isGettingMoreData = false;
        _hasMoreData = r.pages.nextUrl ?? false;
        _messages.addAll(r.messages);
        notifyListeners();
      });
    }
  }

  createMessage(String message, String receiverId) async {
    _sendingMessage = true;
    notifyListeners();
    await MessageRepository()
        .createMessage(message, receiverId)
        .then((messageModel) {
      _sendingMessage = false;
//      Logger().i(messageModel);
      messageModel.createdAt = DateTime.now();
      if (messageModel != null) {
        _messages.insert(0, messageModel);
      }
      notifyListeners();
    });
  }

  List<Message> get messages => _messages;

  bool get hasMoreData => _hasMoreData;

  bool get isGettingMoreData => _isGettingMoreData;

  bool get isFetchingData => _isFetchingData;

  AppError get appError => _appError;

  bool get sendingMessage => _sendingMessage;

  bool get shouldShowPageLoader => _isFetchingData && _messages.length == 0;

  bool get shouldShowAppError => _appError != null && _messages.length == 0;
}
