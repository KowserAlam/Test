import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_candidate/view/manage_candidate_screen.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/repositories/manage_job_repository.dart';
import 'package:jobxprss_company/features/manage_jobs/view/job_details.dart';
import 'package:jobxprss_company/features/manage_jobs/view/post_new_job_screen.dart';
import 'package:jobxprss_company/features/manage_jobs/view/widgets/job_status_widget.dart';
import 'package:jobxprss_company/features/manage_jobs/view_models/manages_jobs_view_model.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/method_extension.dart';

class JobListTileWidget extends StatelessWidget {
  final JobListModel jobModel;
  final Function onApply;
  final Function onFavorite;
  final int index;

  JobListTileWidget(this.jobModel, {this.onFavorite, this.onApply, this.index});

  @override
  Widget build(BuildContext context) {
    String publishDateText = jobModel.postDate == null
        ? ""
        : DateFormatUtil().dateFormat1(jobModel.postDate);

    String deadLineText = jobModel.applicationDeadline != null
        ? jobModel.applicationDeadline.isBefore(DateTime.now())
            ? 'Date Expired'
            : jobModel.applicationDeadline
                    .difference(DateTime.now())
                    .inDays
                    .toString() +
                ' day(s) remaining'
        : "";
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;
    var backgroundColor = Theme.of(context).backgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    var titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    var subTitleStyle = TextStyle(fontSize: 12, color: subtitleColor);
    double iconSize = 12;
    var jobTitle = InkWell(
        onTap: () {
          _navigateToJobDetailsScreen();
        },
        child: Text(
          jobModel.title ?? "",
          style: titleStyle,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ));
    var companyLocation = Row(
      children: <Widget>[
        Icon(
          FeatherIcons.mapPin,
          color: subtitleColor,
          size: iconSize,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          jobModel.jobCity ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: subTitleStyle,
        )
      ],
    );
    bool isDateExpired = jobModel.applicationDeadline != null
        ? (jobModel.applicationDeadline.isBefore(DateTime.now()) &&
            !jobModel.applicationDeadline.isToday())
        : true;

    var viewApplications = Tooltip(
      message: "View Applications",
      child: InkWell(
        onTap: () {
          _navigateToApplicationsScreen();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${jobModel.appliedCount} ${StringResources.viewApplicationsText} ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    );
    var editButton = IconButton(
      constraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      iconSize: 18,
      tooltip: "Edit Job",
      color: primaryColor,
      icon: Icon(FeatherIcons.edit),
      onPressed: () {
        _navigateToEditNNewJobScreen();
      },
    );
    var menu = IconButton(
      constraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      iconSize: 18,
      tooltip: "Menu",
      key: Key('menuButtonKey$index'),
      icon: Icon(FontAwesomeIcons.ellipsisV),
      onPressed: () {
        _showBottomSheet(context);
      },
    );

    var jobType = Row(
      children: <Widget>[
        Icon(
          FeatherIcons.zap,
          size: iconSize,
          color: subtitleColor,
        ),
        SizedBox(width: 5),
        Text(
          jobModel?.jobType?.toSentenceCase ?? "",
          style: subTitleStyle,
        ),
      ],
    );
    var applicationDeadlineWidget = deadLineText.isNotEmptyOrNotNull
        ? Row(
            children: <Widget>[
              Icon(FeatherIcons.clock, size: iconSize, color: subtitleColor),
              SizedBox(width: 5),
              Text(
                deadLineText,
                style: subTitleStyle.apply(
                    color: isDateExpired ? Colors.red : subtitleColor),
              ),
            ],
          )
        : SizedBox();

    var publishDate = Row(
      key: Key('publishedDateKey'),
      children: <Widget>[
        Icon(
          FeatherIcons.calendar,
          size: iconSize,
          color: subtitleColor,
        ),
        SizedBox(width: 5),
        Text(
          publishDateText,
          style: subTitleStyle,
        ),
      ],
    );
    var jobStatus = JobStatusWidget(jobModel.jobStatus, isDateExpired);

    return Container(

      decoration: BoxDecoration(
        borderRadius: CommonStyle.borderRadius,
        color: scaffoldBackgroundColor,
        boxShadow: CommonStyle.boxShadow,
      ),
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Material(
        borderRadius: CommonStyle.borderRadius,
        color: backgroundColor,
        child: InkWell(
          onLongPress: () {
            _showBottomSheet(context);
          },
          onTap: () {
            _showBottomSheet(context);
          },
          child: LayoutBuilder(builder: (context, constrain) {
            bool isTablet = context.isTablet;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(child: jobTitle),
                          if (isTablet)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: jobStatus,
                            ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
//                        if (jobModel.jobCity != null) companyLocation,

                          if (isTablet) publishDate,
                          if (isTablet) applicationDeadlineWidget,
                          jobType,
                          if (isTablet) viewApplications,

                          if (!isTablet) jobStatus,
                          isTablet
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      iconSize: 20,
                                      tooltip: "View job",
                                      icon: Icon(FeatherIcons.eye),
                                      onPressed: () {
                                        _navigateToJobDetailsScreen();
                                      },
                                      color: Colors.green,
                                    ),
                                    IconButton(
                                        iconSize: 20,
                                        tooltip: "Edit job",
                                        icon: Icon(FeatherIcons.edit),
                                        onPressed: () {
                                          _navigateToEditNNewJobScreen();
                                        }),
                                    IconButton(
                                        iconSize: 20,
                                        tooltip: "Copy job as new",
                                        icon: Icon(FeatherIcons.copy),
                                        onPressed: () {
                                          _navigateToEditNNewJobScreen(true);
                                        }),
                                  ],
                                )
                              : menu,
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isTablet)
                  Column(
                    children: [
                      Divider(height: 1),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: publishDateText.isEmptyOrNull?SizedBox():
                              publishDate,
                            ),
                            Expanded(
                                flex: 4,
                                child: applicationDeadlineWidget),
                            viewApplications,
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  _showBottomSheet(context) {
    var jobStatus = jobModel.jobStatus;
    bool allowEdit = jobStatus != JobStatus.PUBLISHED;
    bool isPublished = jobStatus == JobStatus.PUBLISHED;
    bool isDraft = jobStatus == JobStatus.DRAFT;
    bool isUnPublished = jobStatus == JobStatus.UNPUBLISHED;
    var vm = Get.find<ManageJobViewModel>();

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
        // view

        // unpublish
        if (isDraft)
          ListTile(
            onTap: () {
              Navigator.pop(context);
              vm.changeJobStatus(JobStatus.POSTED, jobModel.jobId, index);
            },
            leading: Icon(
              FontAwesomeIcons.checkSquare,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              StringResources.postText,
            ),
          ),

        // unpublish
        if (isPublished)
          ListTile(
            onTap: () {
              Navigator.pop(context);
              vm.changeJobStatus(JobStatus.UNPUBLISHED, jobModel.jobId, index);
            },
            leading: Icon(
              FontAwesomeIcons.folderMinus,
              color: Colors.red,
            ),
            title: Text(
              StringResources.unpublishText,
              style: TextStyle(color: Colors.red),
            ),
          ),
        // publish
        if (isUnPublished)
          ListTile(
            onTap: () {
              Navigator.pop(context);
              vm.changeJobStatus(JobStatus.PUBLISHED, jobModel.jobId, index);
            },
            leading: Icon(
              FontAwesomeIcons.folder,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              StringResources.publishText,
            ),
          ),

        ListTile(
          key: Key('menuPreviewJobDetailsKey'),
          onTap: () {
            Navigator.pop(context);
            _navigateToJobDetailsScreen();
          },
          leading: Icon(
            FeatherIcons.eye,
            color: Colors.green,
          ),
          title: Text(StringResources.previewText),
        ),
//edit
        ListTile(
          onTap: allowEdit
              ? () {
                  Navigator.pop(context);
                  _navigateToEditNNewJobScreen();
                }
              : null,
          leading: Icon(
            FeatherIcons.edit,
            color: allowEdit ? Colors.black : Colors.grey,
          ),
          title: Text(
            StringResources.editText,
            style: TextStyle(color: !allowEdit ? Colors.grey : null),
          ),
        ),
//copy
        ListTile(
          onTap: () {
            Navigator.pop(context);
            _navigateToEditNNewJobScreen(true);
          },
          leading: Icon(
            FeatherIcons.copy,
            color: Colors.black,
          ),
          title: Text(StringResources.copyAsNewText),
        ),
        // view applications
        ListTile(
          key: Key('menuViewApplicationsTextKey'),
          onTap: () {
            Navigator.pop(context);
            _navigateToApplicationsScreen();
          },
          leading: Icon(
            FontAwesomeIcons.fileWord,
            color: Colors.black,
          ),
          title: Text(StringResources.viewApplicationsText),
        ),
      ],
    );
    Get.context.isTablet
        ? showGeneralDialog(
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            transitionDuration: const Duration(milliseconds: 400),
            barrierColor: const Color(0x80000000),
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) =>
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
            context: context,
            builder: (context) => items);
  }

  _navigateToJobDetailsScreen() {
    Get.to(JobDetails(jobModel.slug));
    // Navigator.of(context).push(CupertinoPageRoute(
    //     builder: (context) => JobDetails(jobModel.slug)));
  }

  _navigateToEditNNewJobScreen([bool copyAsNew = false]) {
    BotToast.showLoading();
    ManageJobRepository().fetchJobDetails(jobModel.slug).then((value) {
      value.fold((l) {
        BotToast.closeAllLoading();
      }, (r) {
        BotToast.closeAllLoading();
        Get.to(PostNewJobScreen(
          jobModel: r,
          copyAsNew: copyAsNew,
        ));
        // Navigator.push(
        //     context,
        //     CupertinoPageRoute(
        //         builder: (context) => PostNewJobScreen(
        //               jobModel: r,
        //               copyAsNew: copyAsNew,
        //             )));
      });
    });
  }

  _navigateToApplicationsScreen() {
    Get.to(ManageCandidateScreen(jobModel.jobId));
    // Navigator.push(
    //     context,
    //     CupertinoPageRoute(
    //         builder: (BuildContext context) =>
    //             ManageCandidateScreen(jobModel.jobId)));
  }
}
