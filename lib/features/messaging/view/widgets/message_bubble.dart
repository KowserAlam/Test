import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/features/messaging/model/conversation_screen_data_model.dart';
import 'package:jobxprss_company/features/messaging/model/message_sender_data_model.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final MessageSenderModel senderModel;

  MessageBubble(
    this.message,
    this.senderModel,
  );

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var userProfileVm = Provider.of<CompanyProfileViewModel>(context);
    var userId = userProfileVm?.company?.user;
    bool isMe = userId == message.sender;
    var appUser = userProfileVm?.company;
//    logger.i("userID: $userId senderID: ${message.sender}");

    Color bubbleColor = !isMe ? Colors.white : primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMe)
              Container(
                margin: const EdgeInsets.fromLTRB(8, 25, 8, 8),
                height: 25,
                width: 25,
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  elevation: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: senderModel?.otherPartyImage ?? "",
                      fit: BoxFit.cover,
                      placeholder: (__, _) => Image.asset(
                        kDefaultUserImageAsset,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
//                if (!isMe)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        DateFormatUtil.formatDateTime(message?.createdAt) ?? "",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Container(
                    constraints: BoxConstraints(minWidth: 35, maxWidth: 280),
//                    decoration: BoxDecoration(
//                      boxShadow: CommonStyle.boxShadow,
//                      borderRadius: BorderRadius.only(
//                        bottomLeft: Radius.circular(20),
//                        bottomRight: Radius.circular(isMe ? 0 : 20),
//                        topRight: Radius.circular(20),
//                        topLeft: Radius.circular(!isMe ? 0 : 20),
//                      ),
//                      color: bubbleColor,
//                    ),
                    child: Material(
                      color: bubbleColor,
                      elevation: 2,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(isMe ? 0 : 20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(!isMe ? 0 : 20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableLinkify(
                          text: message?.message ?? "",
                          onOpen: (v) {
                            logger.i(v.url);
                            launch(v.url);
                          },
//                    softWrap: true,
                        ),
                      ),
                    )),
              ],
            ),
            if (isMe)
              Container(
                margin: const EdgeInsets.fromLTRB(8, 25, 8, 8),
                height: 25,
                width: 25,
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  elevation: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: appUser?.profilePicture ?? "",
                      fit: BoxFit.cover,
                      placeholder: (__, _) => Image.asset(
                        kCompanyImagePlaceholder,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
