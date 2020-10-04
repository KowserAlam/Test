import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/messaging/model/conversation_screen_data_model.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LiveUpdateService extends GetxController {
  // var  notificationLive = NotificationModel().obs;
  var messageLive = Message().obs;

  // var notificationUpdate = PublishSubject<NotificationModel>();
  initSocket() async {
    logger.i("initSocket");
    var token = await AuthService.getInstance()
        .then((value) => value.getUser().accessToken);
    var url = "https://iss.ishraak.com?token=$token";
    logger.i(url);
    // Dart client
    IO.Socket socket = IO.io(url, {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.on('connect', (_) {
      logger.i('connect');
//      socket.emit('receive', 'test');
    });
    socket.on('event', (data) => logger.i(data));
    socket.on('disconnect', (_) => logger.i('disconnect'));
    socket.on('receive', (d) {
      var data = json.decode(d);
      logger.i(data);

      // if (data['type'] == "notification") {
      //   logger.i("notification");
      //   var notificationMap = json.decode(data["text"]);
      //   logger.i(notificationMap);
      //   // var notification = NotificationModel.fromJson(notificationMap);
      //   // notificationLive.value = notification;
      //   // notificationUpdate.sink.add(notification);
      // }

      if (data['type'] == "message") {
        logger.i("message");
        var messageMap = json.decode(data["text"]);
        logger.i(messageMap);
        var msg = Message.fromJson(messageMap);
        messageLive.value = msg;
        // notificationUpdate.sink.add(notification);
        Get.snackbar(msg?.senderPro?.fullName ?? "", msg.message,
            backgroundColor: Colors.white,);
      }
    });
    // socket.connect();
  }

  dispose() {
    // notificationUpdate.close();
  }
}
