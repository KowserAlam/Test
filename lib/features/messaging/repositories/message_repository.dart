import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:jobxprss_company/features/messaging/model/conversation_screen_data_model.dart';
import 'package:jobxprss_company/features/messaging/model/message_sender_data_model.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
export 'package:jobxprss_company/features/messaging/model/conversation_screen_data_model.dart';
export 'package:jobxprss_company/features/messaging/model/message_sender_data_model.dart';
export 'package:jobxprss_company/main_app/failure/app_error.dart';

class MessageRepository {
  Future<Either<AppError, List<MessageSenderModel>>> getSenderList() async {
    try {
      var response = await ApiClient().getRequest(Urls.messageSenderListUrl);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        var list = <MessageSenderModel>[];
        var decodesJson = json.decode(utf8.decode(response.bodyBytes));
//        logger.i(decodesJson);
        decodesJson.forEach((v) {
          list.add(MessageSenderModel.fromJson(v));
        });
        return Right(list);
      } else if (response.statusCode == 401) {
        BotToast.showText(text: StringResources.unauthorizedText);
        return Left(AppError.unauthorized);
      } else {
        BotToast.showText(text: StringResources.somethingIsWrong);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      return Left(AppError.networkError);
    } catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.somethingIsWrong);
      return Left(AppError.serverError);
    }
  }

  Future<Either<AppError, ConversationScreenDataModel>> getConversation(
      String senderId,{int page=1}) async {
    try {
      var url = "${Urls.senderMessageListUrl}$senderId&page=${page??1}";
      var response = await ApiClient().getRequest(url);
//      logger.i(response.statusCode);
//      Logger().i(response.body);
      if (response.statusCode == 200) {
        var decodesJson = json.decode(utf8.decode(response.bodyBytes));
//        Logger().i(decodesJson);
        return Right(ConversationScreenDataModel.fromJson(decodesJson));
      } else if (response.statusCode == 401) {
        return Left(AppError.unauthorized);
      } else {
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      return Left(AppError.networkError);
    } catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.somethingIsWrong);
      return Left(AppError.serverError);
    }
  }

  Future<Message> createMessage(String message, String receiverId) async {
    var url = "${Urls.createMessageListUrl}";

//    logger.i(url);
    try {
      var res = await ApiClient().postRequest(
        url,
        {
          'receiver': receiverId,
          'message': message,
        },
      );
//      logger.i(res.statusCode);
//      logger.i(res.body);
      if (res.statusCode == 201) {
        var decodedJson = json.decode(utf8.decode(res.bodyBytes));
//        Logger().i(decodedJson);
        return Message.fromJson(decodedJson);
      }
      return null;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

//  Future<bool> markAsRead(int id) async {
//    var url = "${Urls.messageMarkedReadUrl}/${id}/";
//
////    logger.i(url);
//    try {
//      var res = await ApiClient().putRequest(
//        url,
//        {'is_read': 1},
//      );
//      logger.i(res.statusCode);
//      logger.i(res.body);
//      if (res.statusCode == 200) {
//        return true;
//      } else {}
//      return false;
//    } catch (e) {
//      logger.e(e);
//      return false;
//    }
//  }
}
