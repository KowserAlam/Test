import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/features/messaging/view/conversation_screen.dart';
import 'package:jobxprss_company/features/messaging/view/widgets/no_message_widget.dart';
import 'package:jobxprss_company/features/messaging/view_mpdel/message_sender_list_screen_view_model.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/page_state_builder.dart';
import 'package:provider/provider.dart';

class MessageListScreen extends StatefulWidget {
  @override
  _MessageListScreenState createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();
  var _messageInoutTextEditingController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CompanyProfileViewModel>(context, listen: false)
        .getCompanyDetails();
    var notiVM =
        Provider.of<MessageSenderListScreenViewModel>(context, listen: false);
    notiVM.getSenderList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        notiVM.getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<MessageSenderListScreenViewModel>(context);
    return Scaffold(
appBar: AppBar(
  title: Text(StringResources.messagesText, key: Key('messageListScreenAppBarKey'),),
),
      body: PageStateBuilder(
        onRefresh: () => vm.refresh(),
        appError: vm.appError,
        showLoader: vm.shouldShowPageLoader,
        showError: vm.shouldShowAppError,
        child: Consumer<MessageSenderListScreenViewModel>(
            builder: (context, messagesViewModel, _) {
          if (messagesViewModel.shouldShowNoMessage) {
            return NoMessagesWidget();
          }

          return RefreshIndicator(
            onRefresh: () async => messagesViewModel.getSenderList(),
            child: SafeArea(
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  itemCount: messagesViewModel.senderList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var senderModel = messagesViewModel.senderList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          boxShadow: CommonStyle.boxShadow),
                      child: Material(
                        type: MaterialType.transparency,
                        child: RawMaterialButton(
                            onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) =>
                                      ConversationScreen(senderModel)));
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: CachedNetworkImage(
                                        imageUrl: senderModel.otherPartyImage,
                                        fit: BoxFit.cover,
                                        placeholder: (__, _) => Image.asset(
                                          kDefaultUserImageAsset,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child:
                                        Text(senderModel.otherPartyName ?? ""))
                              ],
                            )),
                      ),
                    );
                  }),
            ),
          );
        }),
      ),
    );
  }
}
