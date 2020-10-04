import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/messaging/view/widgets/message_bubble.dart';
import 'package:jobxprss_company/features/messaging/view_model/conversation_view_model.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  final MessageSenderModel senderModel;
//  final String senderListId;

  ConversationScreen(this.senderModel,);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();
  var _messageInoutTextEditingController = TextEditingController();
  ConversationViewModel vm;
  
  @override
  void initState() {
    Get.put(ConversationViewModel(),tag: widget.senderModel.otherPartyUserId);
    vm = Get.find<ConversationViewModel>(tag: widget.senderModel.otherPartyUserId);
    vm.listenLiveMessage(widget.senderModel.otherPartyUserId);
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
   vm.getConversation(widget.senderModel.otherPartyUserId);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        vm.getMoreData(widget.senderModel.otherPartyUserId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationViewModel>(
        tag: widget.senderModel.otherPartyUserId,
        init:ConversationViewModel(),
        builder: (vm) {
      var messages = vm.messages;
      return Scaffold(
        appBar: AppBar(
          title: Text(widget?.senderModel?.otherPartyName ?? ""),
          actions: [
            // IconButton(
            //   onPressed: vm.isFetchingData ? null : () {
            //     vm.refresh(widget.senderModel.otherPartyUserId);
            //
            //     _scrollController.animateTo(
            //         _scrollController.initialScrollOffset,
            //         duration: Duration(milliseconds: 500), curve:Curves.easeIn);
            //   },
            //   icon: vm.isFetchingData ? Loader() : Icon(Icons.refresh),
            // ),
          ],
        ),
//      drawer: AppDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: vm.shouldShowPageLoader
                    ? Loader()
                    : ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    itemCount: messages.length + 1,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == messages.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: vm.isGettingMoreData
                              ? Loader()
                              : SizedBox(),
                        );
                      }

                      var message = messages[index];
                      return MessageBubble(message, widget.senderModel);
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: CommonStyle.boxShadow,
                            color: Theme
                                .of(context)
                                .backgroundColor
                                .withBlue(255),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextField(
                            controller: _messageInoutTextEditingController,
                            decoration: InputDecoration(
                                hintText:
                                StringResources.writeYourMessageText,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ),
                  vm.sendingMessage
                      ? IconButton(
                    icon: Loader(),
                    onPressed: null,
                  )
                      : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
                    child: Material(
                      elevation: 3,
                      shape: CircleBorder(),
                      child: InkWell(
                        key: Key('sendMessageButton'),
                        customBorder: CircleBorder(),
                        onTap: () {
                          if (_messageInoutTextEditingController
                              .text.isNotEmpty) {
                            vm.createMessage(
                                _messageInoutTextEditingController.text,
                                widget.senderModel.otherPartyUserId);
                            _messageInoutTextEditingController.clear();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Transform.rotate(
                            angle: 0.8,
                            child: Icon(FeatherIcons.send),
                          ),
                        ),
                      ),
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
