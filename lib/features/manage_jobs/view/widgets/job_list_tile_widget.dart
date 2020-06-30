import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:jobxprss_company/features/job_post/view/post_new_job_screen.dart';
import 'package:jobxprss_company/features/manage_candidate/view/manage_candidate_screen.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/view/job_details.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/method_extension.dart';

class JobListTileWidget extends StatefulWidget {
  final JobListModel jobModel;
  final Function onApply;
  final Function onFavorite;

  JobListTileWidget(this.jobModel, {this.onFavorite, this.onApply});

  @override
  _JobListTileWidgetState createState() => _JobListTileWidgetState();
}

class _JobListTileWidgetState extends State<JobListTileWidget> {
  @override
  Widget build(BuildContext context) {
    String publishDateText = widget.jobModel.postDate == null
        ? StringResources.unspecifiedText
        : DateFormatUtil().dateFormat1(widget.jobModel.postDate);

    String deadLineText = widget.jobModel.applicationDeadline == null
        ? StringResources.unspecifiedText
        : DateFormatUtil().dateFormat1(widget.jobModel.applicationDeadline);
//    bool isDateExpired = widget.jobModel.applicationDeadline != null
//        ? DateTime.now().isAfter(widget.jobModel.applicationDeadline)
//        : true;

//    debugPrint("Deadline: ${widget.jobModel.applicationDeadline}\n Today: ${DateTime.now()} \n $isDateExpired");
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;
    var backgroundColor = Theme.of(context).backgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    var titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    var subTitleStyle = TextStyle(fontSize: 12, color: subtitleColor);
    double iconSize = 12;
    var jobTitle = Text(
      widget.jobModel.title ?? "",
      style: titleStyle,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
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
          widget.jobModel.jobCity ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: subTitleStyle,
        )
      ],
    );
    bool isDateExpired = widget.jobModel.applicationDeadline != null
        ? (widget.jobModel.applicationDeadline.isBefore(DateTime.now()) &&
            !widget.jobModel.applicationDeadline.isToday())
        : true;
    var jobStatus = Container(
      child: Text(
        isDateExpired ? "Expired" : "Active",
        style: subTitleStyle.apply(color: Colors.green),
      ),
    );
    var viewApplications = Tooltip(
      message: "View Applications",
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) => ManageCandidateScreen(widget.jobModel.jobId)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${StringResources.viewApplicationsText} ${widget.jobModel.appliedCount}",
            style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 12),
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
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => PostNewJobScreen()));
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
          widget.jobModel?.jobType?.toSentenceCase ?? "",
          style: subTitleStyle,
        ),
      ],
    );
    var applicationDeadlineWidget = Row(
      children: <Widget>[
        Icon(FeatherIcons.clock, size: iconSize, color: subtitleColor),
        SizedBox(width: 5),
        Text(
          deadLineText,
          style: subTitleStyle,
        ),
      ],
    );

    var publishDate = Row(
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

    return Container(
      decoration: BoxDecoration(color: scaffoldBackgroundColor, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 17),
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 17),
      ]),
      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => JobDetails(widget.jobModel.slug)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    jobTitle,
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.jobModel.jobCity != null) companyLocation,
                        jobType,
                        jobStatus,
                        editButton,
                      ],
                    ),
                  ],
                ),
              ),
              //Job Title
              Divider(height: 1),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    publishDate,
                    applicationDeadlineWidget,
                    viewApplications,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
