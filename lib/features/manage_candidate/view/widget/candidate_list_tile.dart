import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/features/manage_candidate/view/candidate_profile_scren.dart';
import 'package:jobxprss_company/features/manage_candidate/view_models/manage_candidate_view_model.dart';
import 'package:jobxprss_company/features/messaging/model/message_sender_data_model.dart';
import 'package:jobxprss_company/features/messaging/repositories/message_repository.dart';
import 'package:jobxprss_company/features/messaging/view/conversation_screen.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class CandidateListTile extends StatelessWidget {
  final Candidate candidate;
  final int index;
  final String jobId;

  CandidateListTile(this.candidate,
      {@required this.index, @required this.jobId});

  @override
  Widget build(BuildContext context) {
    final ManageCandidateVewModel manageCandidateVm =
        Get.find<ManageCandidateVewModel>(tag: jobId);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;
    var backgroundColor = Theme.of(context).backgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    var titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    var subTitleStyle = TextStyle(fontSize: 12, color: subtitleColor);
    double iconSize = 12;

    // var vm = //Provider.of<CompanyProfileViewModel>(context);

    var name = Text(candidate.fullName ?? "");
    // candidate.

    String year(){
      if(candidate.experience==null || candidate.experience=='0' || candidate.experience=='1'){
        return 'Year';
      }else{return 'Years';}
    }
    var experience = Text(
      "${candidate.experience ?? "0"} "+ year() +" of Experience" ,
      style: subTitleStyle,
    );
    var skills = Text(
      "Skills: ${candidate.skills.join(", ")}",
      style: subTitleStyle,
    );
    String designationText = "${candidate.currentDesignation ?? ""}${candidate.currentDesignation!=null?', ':''} ${candidate.currentCompany ?? ""}";
    var designation = designationText.trim()!=''?Text(
      designationText,
      style: subTitleStyle,
    ):SizedBox();

    String statusText = candidate.applicationStatusName!=null?candidate.applicationStatusName:'';
    var status = statusText.trim()!=''?Text(
      statusText,
      style: subTitleStyle,
    ):SizedBox();

    var profileImage = Container(
      height: 80,
      width: 80,
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

      decoration: BoxDecoration(
          borderRadius: CommonStyle.borderRadius,
          color: scaffoldBackgroundColor, boxShadow: CommonStyle.boxShadow),
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Material(
        color: backgroundColor,
          borderRadius: CommonStyle.borderRadius,
        child: InkWell(
          onTap: () {
            Get.to(CandidateProfileScreen(candidate.slug));
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileImage,
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      name,
                      SizedBox(height: 5,),
                      designation,
                      SizedBox(height: designationText!=''?3:0,),
                      experience,
                      SizedBox(height: 3,),
                      skills,
                      // SizedBox(height: 3,),
                      // status,
                    ],
                  ),
                ),
                Column(
                  children: [
                    // message
                    IconButton(
                      iconSize: 20,
                      onPressed: () {
                        _showBottomSheet(context);
                      },
                      icon: Icon(FontAwesomeIcons.ellipsisV),
                    ),

                    ValueBuilder<bool>(
                        initialValue: false,
                        builder: (isLoading, updateFn) {
                          if (isLoading) {
                            return IconButton(
                              icon: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Loader(size: 8,),
                              ),
                              onPressed: null,
                            );
                          }
                          return IconButton(
                            iconSize: 20,
                            onPressed: () {
                              updateFn(true);
                              manageCandidateVm
                                  .toggleCandidateShortlistedStatus(
                                      candidate.applicationId, index).then((value) {
                                        manageCandidateVm.getDataShortlisted(jobId);
                                updateFn(false);
                              });
                            },
                            icon: Stack(
                              children: [
                                if (candidate.isShortlisted)
                                  Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color:
                                        Theme.of(context).primaryColor,
                                  ),
                                Icon(
                                  FontAwesomeIcons.heart,
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
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
  _showBottomSheet(context1){
    var items = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 12,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          ),
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.comment),
          title: Text('Message'),
          onTap: (){
            var model = MessageSenderModel(
                otherPartyImage: candidate.image,
                otherPartyName: candidate.fullName,
                otherPartyUserId: candidate.user);
            Get.to(ConversationScreen(
              model,
//                              senderListId: vm.company?.user?.toString(),
            ));
          },
        ),
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Change Candidate Status'),
         // onTap:
          onTap:(){
            print('123');
            Navigator.pop(context1);
            _applicationStatusDialogue(context1);
        },
        )
      ],
    );

    Get.context.isTablet
        ? showGeneralDialog(
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context1).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 400),
        barrierColor: const Color(0x80000000),
        context: context1,
        pageBuilder: (context1, animation, secondaryAnimation) =>
            AlertDialog(
              content: items,
              actions: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(StringResources.closeText),
                  ),
                )
              ],
            ))
        : showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        context: context1,
        builder: (context1) => items);
  }

  _applicationStatusDialogue(ctx){
    TextEditingController noteController = TextEditingController();
    showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (_)=> AlertDialog(
        title: Text('Add a note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              hintText: 'Type here',
              controller: noteController,
              maxLines: 3,
            ),
            FlatButton(
              child: Text('ADD'),
              onPressed: (){
                Navigator.pop(ctx);
                print('meh');
              },
            )
          ],
        )
      )
    );
  }


}
