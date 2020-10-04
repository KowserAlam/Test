
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/messaging/model/message_sender_data_model.dart';
import 'package:jobxprss_company/features/messaging/repositories/message_repository.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
class MessageSenderListScreenViewModel extends GetxController {
  AppError _appError;
  List<MessageSenderModel> _messages = [];
  bool _isFetchingData = false;
  bool _isGettingMoreData = false;
  bool _hasMoreData = false;

  Future<void> refresh() {
    return getSenderList();
  }

  Future<void> getSenderList() async {
    _isFetchingData = true;
    update();
    var res = await MessageRepository().getSenderList();
    return res.fold((l) {
      _isFetchingData = false;
      _hasMoreData = false;
      _appError = l;
      update();
      return;
    }, (r) {
      _isFetchingData = false;
      _messages = r ?? [];
//      _hasMoreData = r.next;
      update();
      return;
    });
  }

  getMoreData() async {
    if (_hasMoreData && !isGettingMoreData) {
      _isGettingMoreData = true;
      update();
      var res = await MessageRepository().getSenderList();
      res.fold((l) {
        _isGettingMoreData = false;
        _appError = l;
        _hasMoreData = false;
        update();
      }, (r) {
        _isGettingMoreData = false;
//        _hasMoreData = r.next;
//        _messages.addAll(r.messages);
        update();
      });
    }
  }


//  markAsRead(int index) {
//    if (!_messages[index].isRead) {
//      messages[index].isRead = true;
//      update();
//      MessageRepository()
//          .markAsRead(messages[index].id)
//          .then((value) {
//        if (!value) {
//          messages[index].isRead = false;
//          update();
//        }
//      });
//    }
//  }

  List<MessageSenderModel> get senderList => _messages;

  set senderList(List<MessageSenderModel> value) {
    _messages = value;
  }

  AppError get appError => _appError;

  set appError(AppError value) {
    _appError = value;
  }

  bool get isGettingMoreData => _isGettingMoreData;

  bool get isFetchingData => _isFetchingData;

  bool get hasMoreData => _hasMoreData;

  bool get shouldShowPageLoader => _isFetchingData && senderList.length == 0;

  bool get shouldShowAppError => _appError != null && senderList.length == 0;

  bool get shouldShowNoMessage =>
      !_isFetchingData && _appError == null && senderList.length == 0;
}