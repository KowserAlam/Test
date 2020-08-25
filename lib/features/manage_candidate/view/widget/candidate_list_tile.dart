import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/features/messaging/model/message_sender_data_model.dart';
import 'package:jobxprss_company/features/messaging/repositories/message_repository.dart';
import 'package:jobxprss_company/features/messaging/view/conversation_screen.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:provider/provider.dart';

class CandidateListTile extends StatelessWidget {
  final Candidate candidate;

  CandidateListTile(this.candidate);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;
    var backgroundColor = Theme.of(context).backgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    var titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    var subTitleStyle = TextStyle(fontSize: 12, color: subtitleColor);
    double iconSize = 12;

    var vm = Provider.of<CompanyProfileViewModel>(context);

    var name = Text(candidate.fullName ?? "");

    var experience = Text(
      "Experience: ${candidate.experience ?? "0"} year",
      style: subTitleStyle,
    );
    var skills = Text(
      " Skills: ${candidate.skills.join(", ")}",
      style: subTitleStyle,
    );
    var designation = Text(
      "${candidate.currentDesignation ?? ""} @${candidate.currentCompany ?? ""}",
      style: subTitleStyle,
    );
    var profileImage = Container(
      height: 60,
      width: 60,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: candidate.image ?? "",
        placeholder: (c, u) => Image.asset(
          kDefaultUserImageAsset,
          fit: BoxFit.cover,
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(color: scaffoldBackgroundColor, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 17),
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 17),
      ]),
      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        profileImage,
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              name,
                              designation,
                              experience,
                              skills,
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
//                            _showSendMessageDialog(context);
//
                            var model = MessageSenderModel(
                                otherPartyImage: candidate.image,
                                otherPartyName: candidate.fullName,
                                otherPartyUserId: candidate.user);
                            Get.to(ConversationScreen(
                              model,
//                              senderListId: vm.company?.user?.toString(),
                            ));
                          },
                          icon: Icon(FontAwesomeIcons.comment),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Job Title
//              Divider(height: 1),
//              Padding(
//                padding: EdgeInsets.all(8),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[],
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }

//  _showSendMessageDialog(context) {
//    showGeneralDialog(
//      barrierDismissible: true,
//      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//      transitionDuration: const Duration(milliseconds: 400),
//      barrierColor: const Color(0x80000000),
//      context: context,
//      pageBuilder: (context, animation, secondaryAnimation) {
//
//        return StatefulBuilder(
//          builder: (BuildContext context, setState) {
//            var textController = TextEditingController();
//            var formKey = GlobalKey<FormState>();
//            return Center(
//              child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Material(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(7)),
//                  child: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    children: [
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          candidate.fullName,
//                          style: Theme.of(context).textTheme.headline6,
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Form(
//                          key: formKey,
//                          child: CustomTextFormField(
//                            validator: Validator().nullFieldValidate,
//                            controller: textController,
//                            maxLines: 15,
//                            minLines: 8,
//                            keyboardType: TextInputType.multiline,
//                          ),
//                        ),
//                      ),
//                      RaisedButton(
//                        onPressed: () async {
//
//                          var v = formKey.currentState.validate();
//                          if(v){
//                            MessageRepository()
//                                .createMessage(textController.text, candidate.user);
//                            Navigator.pop(context);
//                          }
//
//                        },
//                        child: Text(StringResources.sendText),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            );
//          },
//        );
//      },
//    );
//  }
}
