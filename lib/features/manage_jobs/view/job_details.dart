import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as dartZ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/company_profile/view/company_profile.dart';
import 'package:jobxprss_company/features/manage_candidate/view/manage_candidate_screen.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_model.dart';
import 'package:jobxprss_company/features/manage_jobs/repositories/manage_job_repository.dart';
import 'package:jobxprss_company/features/manage_jobs/view/post_new_job_screen.dart';
import 'package:jobxprss_company/features/manage_jobs/view_models/manages_jobs_view_model.dart';
import 'package:jobxprss_company/main_app/api_helpers/url_launcher_helper.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:jobxprss_company/main_app/views/widgets/failure_widget.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jobxprss_company/method_extension.dart';

class JobDetails extends StatefulWidget {
  final String slug;
  final int index;

  JobDetails(this.slug, this.index);

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  JobModel jobDetails;

//  Company jobCompany;
  bool _isBusy = false;
  AppError _appError;

  @override
  void initState() {
    // TODO: implement initState
//    getDetails();
    logger.i(widget.slug);
    getJobDetails();
    super.initState();
  }

  _showApplyDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(StringResources.doYouWantToApplyText),
            actions: [
              RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(StringResources.noText),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(StringResources.yesText),
              ),
            ],
          );
        });
  }

  String refactorAboutJobStrings(String value) {
    if (value == 'ONSITE') return 'On-site';
    if (value == 'FULLTIME') return 'Full-time';
    if (value == 'PARTTIME') return 'Part-time';
    return value.toSentenceCase;
  }

  errorWidget() {
    switch (_appError) {
      case AppError.serverError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.unableToLoadData,
          onTap: () {},
        );

      case AppError.networkError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.couldNotReachServer,
          onTap: () {},
        );

      default:
        return FailureFullScreenWidget(
          errorMessage: StringResources.somethingIsWrong,
          onTap: () {},
        );
    }
  }

  getJobDetails() async {
    _isBusy = true;
    setState(() {});
    dartZ.Either<AppError, JobModel> result =
        await ManageJobRepository().fetchJobDetails(widget.slug);
    return result.fold((l) {
      _isBusy = false;
      _appError = l;
      setState(() {});
      logger.i(l);
    }, (JobModel dataModel) {
      logger.i(dataModel.title);
      jobDetails = dataModel;
      _isBusy = false;
      setState(() {});
    });
  }


//  List<ActionMenuOptions> choices(JobStatus jobStatus){
//    bool allowEdit = jobStatus != JobStatus.PUBLISHED;
//    bool isPublished = jobStatus == JobStatus.PUBLISHED;
//    bool isDraft = jobStatus == JobStatus.DRAFT;
//    bool isUnPublished = jobStatus == JobStatus.UNPUBLISHED;
//    return
//      [
//        ActionMenuOptions(title:'Edit', onTap: (){
//
//        }),
//        ActionMenuOptions(title:'Copy as New', onTap: (){
//
//        })
//      ];
//  }

  List<PopupMenuItem<String>> options(JobStatus jobStatus){
    bool allowEdit = jobStatus != JobStatus.PUBLISHED;
    bool isPublished = jobStatus == JobStatus.PUBLISHED;
    bool isDraft = jobStatus == JobStatus.DRAFT;
    bool isUnPublished = jobStatus == JobStatus.UNPUBLISHED;
    bool isPosted = jobStatus == JobStatus.POSTED;
    List<PopupMenuItem<String>> a = [];
    if(allowEdit){
      a.add(PopupMenuItem<String>(
          value: StringResources.editText,
          child: Text(StringResources.editText)));
    }
    if(isDraft){
      a.add(PopupMenuItem<String>(
        value: StringResources.postText,
        child: Text(StringResources.postText)));
    }
    if(isUnPublished){
      a.add(PopupMenuItem<String>(
        value: StringResources.publishText,
        child: Text(StringResources.publishText),));
    }
    if(isPublished){
      a.add(PopupMenuItem<String>(
        value: StringResources.unpublishText,
        child: Text(StringResources.unpublishText),));
    }
    a.add(
        PopupMenuItem<String>(
          value: StringResources.copyAsNewText,
          child: Text(StringResources.copyAsNewText),),
    );
    a.add(
      PopupMenuItem<String>(
        value: StringResources.viewApplicationsText,
        child: Text(StringResources.viewApplicationsText),),
    );
//    if(isPosted){
//      a.add(PopupMenuItem<String>(
//        value: StringResources.unpublishText,
//        child: Text(StringResources.unpublishText),));
//    }
    return a;
  }

  onOptionSelect(String choice){
    var vm = Get.find<ManageJobViewModel>();
    if(choice == StringResources.editText){
      Get.to(PostNewJobScreen(
        jobModel: jobDetails,
        copyAsNew: false,
      ));
    }else if(choice == StringResources.copyAsNewText){

      jobDetails.title+=" (copy)";

      Get.to(PostNewJobScreen(
        jobModel: jobDetails,
        copyAsNew: true,
      ));
    }else if(choice == StringResources.postText){
      vm.changeJobStatus(JobStatus.POSTED, jobDetails.jobId, widget.index);
      getJobDetails();
    }else if(choice == StringResources.publishText){
      vm.changeJobStatus(JobStatus.PUBLISHED, jobDetails.jobId, widget.index);
      getJobDetails();
    }else if(choice == StringResources.unpublishText){
      vm.changeJobStatus(JobStatus.UNPUBLISHED, jobDetails.jobId, widget.index);
      getJobDetails();
    }else if(choice == StringResources.viewApplicationsText){
      Get.to(ManageCandidateScreen(jobDetails.jobId, false));
    }
  }

//  getCompany(JobModel jobModel) async{
//    CompanyListRepository().getCompanyDetails(jobModel.companyName).then((value) {
//      jobCompany = value;
//      setState(() {
//
//      });
//    });
////    dartZ.Either<AppError, List<Company>> result =
////    await CompanyListRepository().getList(query: jobModel.companyName);
////    return result.fold((l) {
////      logger.i(l);
////    }, (List<Company> dataModel) {
////      logger.i(dataModel[0].name);
////      jobCompany = dataModel[0];
////      setState(() {});
////    });
//  }

  @override
  Widget build(BuildContext context) {
//    var jobDetailViewModel = Provider.of<JobDetailViewModel>(context);

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color sectionColor = Theme.of(context).backgroundColor;
    Color summerySectionBorderColor = Colors.grey[300];
    Color summerySectionColor =
        !isDarkMode ? Colors.grey[200] : Colors.grey[600];
    Color backgroundColor = !isDarkMode ? Colors.grey[200] : Colors.grey[700];

    //Styles
    TextStyle headerTextStyle =
        new TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle sectionTitleFont =
        TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    TextStyle descriptionFontStyle = TextStyle(fontSize: 13);
    TextStyle topSideDescriptionFontStyle = TextStyle(
        fontSize: 14, color: !isDarkMode ? Colors.grey[600] : Colors.grey[500]);
    TextStyle hasCompanyFontStyle =
        TextStyle(fontSize: 14, color: Colors.blueAccent);
    TextStyle descriptionFontStyleBold =
        TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
    double fontAwesomeIconSize = 15;

    Text jobSummeryRichText(String title, String description) {
      return Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(text: title, style: descriptionFontStyleBold),
          TextSpan(text: ': ', style: descriptionFontStyleBold),
          TextSpan(text: description, style: descriptionFontStyle),
        ]),
        style: descriptionFontStyle,
      );
    }

    if (jobDetails == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            StringResources.jobDetailsAppBarTitle,
            key: Key('jobDetailsAppBarTitleKey'),
          ),
        ),
        body: Center(
          child: _isBusy
              ? Loader()
              : SizedBox(
                  child: _appError != null ? errorWidget() : SizedBox(),
                ),
        ),
      );
    }
//logger.i(jobDetails?.company?.profilePicture);
    double iconSize = 14;
    double sectionIconSize = 20;
    Color clockIconColor = Colors.orange;

    bool isFavorite = jobDetails?.isFavourite ?? false;
    bool isApplied = jobDetails?.isApplied ?? false;
//    bool isDateExpired = jobDetails.applicationDeadline != null
//        ? DateTime.now().isAfter(jobDetails.applicationDeadline)
//        : true;

//widgets

    var spaceBetweenSections = SizedBox(
      height: 30,
    );
    var jobHeader = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey[300])),
            margin: EdgeInsets.only(right: 10),
            child: CachedNetworkImage(
              placeholder: (context, _) => Image.asset(
                kCompanyImagePlaceholder,
                fit: BoxFit.cover,
              ),
              imageUrl: jobDetails?.company?.profilePicture ?? "",
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: Text(
                          jobDetails.title != null
                              ? jobDetails.title
                              : "",
                          style: headerTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      jobDetails.company != null
                          ? jobDetails.company.name
                          : "",
                      style: topSideDescriptionFontStyle

                    ),
                    SizedBox(
                      height: 5,
                    ),
//                    if (jobDetails.jobCity.isNotEmptyOrNotNull)
//                      Row(
//                        children: <Widget>[
//                          Icon(
//                            FeatherIcons.mapPin,
//                            size: iconSize,
//                          ),
//                          SizedBox(
//                            width: 5,
//                          ),
//                          Flexible(
//                            child: Text(
//                            jobDetails.jobCity
//                                  ?? StringUtils.unspecifiedText,
//                              style: topSideDescriptionFontStyle,
//                            ),
//                          )
//                        ],
//                      )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
    var description = jobDetails.descriptions.htmlToNotusDocument.toPlainText().trim().length!=0?Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Transform.rotate(
                  angle: pi,
                  child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: FaIcon(
                        FontAwesomeIcons.alignLeft,
                        size: fontAwesomeIconSize,
                      ))),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.jobDescriptionTitle,
                style: sectionTitleFont,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
//          Text(
//            jobDetails.descriptions != null
//                ? jobDetails.descriptions
//                : "",
//            style: descriptionFontStyle,
//          ),
          HtmlWidget(jobDetails.descriptions),
          spaceBetweenSections
        ],
      ),
    ):SizedBox();
    var responsibilities = jobDetails.responsibilities.htmlToNotusDocument.toPlainText().trim().length!=0?Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.bolt,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.responsibilitiesTitle,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
//          Text(
//            jobDetails.responsibilities != null
//                ? jobDetails.responsibilities
//                : "",
//            style: descriptionFontStyle,
//          ),
          HtmlWidget(jobDetails.responsibilities),
          spaceBetweenSections
        ],
      ),
    ):SizedBox();
    var education = jobDetails.education.htmlToNotusDocument.toPlainText().trim().length!=0?Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.book,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.educationTitle,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          HtmlWidget(jobDetails.education),
          spaceBetweenSections
        ],
      ),
    ):SizedBox();

    var additionalRequirements = jobDetails.additionalRequirements.htmlToNotusDocument.toPlainText().trim().length!=0?Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                StringResources.jobAdditionalRequirementsText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          HtmlWidget(jobDetails.additionalRequirements),
          spaceBetweenSections
        ],
      ),
    ):SizedBox();

    var location = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                Icons.pin_drop,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.jobLocation,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringResources.jobAddressText,
              jobDetails.jobAddress != null
                  ? jobDetails.jobAddress
                  : ""),
          SizedBox(
            height: jobDetails.jobArea != null?5:0,
          ),
          jobDetails.jobArea != null?jobSummeryRichText(
              StringResources.jobAreaText,
              jobDetails.jobArea):SizedBox(),
          SizedBox(
            height: jobDetails.jobCity != null?5:0,
          ),
          jobDetails.jobCity != null?jobSummeryRichText(
              StringResources.jobCityText,
              jobDetails.jobCity):SizedBox(),
          SizedBox(
            height: jobDetails.jobCountry != null?5:0,
          ),
          jobDetails.jobCountry != null?jobSummeryRichText(
              StringResources.jobCountryText,
              jobDetails.jobCountry):SizedBox(),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
    var aboutJob = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.exclamationCircle,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.jobAboutText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringResources.jobTypeText,
              jobDetails.jobType != null
                  ? refactorAboutJobStrings(jobDetails.jobType)
                  : ""),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringResources.jobNature,
              jobDetails.jobNature != null
                  ? refactorAboutJobStrings(jobDetails.jobNature)
                  : ""),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringResources.jobSiteText,
              jobDetails.jobSite != null
                  ? refactorAboutJobStrings(jobDetails.jobSite)
                  : ""),
        ],
      ),
    );
    var aboutCompany = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.solidBuilding,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.jobAboutCompanyText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          jobDetails.companyProfile.htmlToNotusDocument.toPlainText().trim().length!=0?Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                StringResources.jobCompanyProfileText + ': ',
                style: descriptionFontStyleBold,
              ),
              GestureDetector(
                  onTap: () {
                    UrlLauncherHelper.launchUrl(
                        jobDetails.companyProfile.trim());
                  },
                  child: HtmlWidget(jobDetails.companyProfile))
            ],
          ):SizedBox(),
          SizedBox(
            height: 5,
          ),
          if (jobDetails.company.webAddress != null)
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: StringResources.companyWebAddressText + ': ',
                  style: descriptionFontStyleBold),
              WidgetSpan(
                  child: InkWell(
                onTap: () {
                  UrlLauncherHelper.launchUrl(
                      jobDetails.company.webAddress?.trim());
                },
                child: Text(
                  jobDetails.company.webAddress ?? "",
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ))
            ])),

          SizedBox(
            height: 5,
          ),
//          jobSummeryRichText(StringUtils.jobNature, jobDetails.jobNature!=null?jobDetails.jobNature:StringUtils.unspecifiedText),
//          SizedBox(height: 5,),
        ],
      ),
    );
    var salary = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.moneyBillWave,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.salaryTitle,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          jobDetails.salary != null?jobSummeryRichText(
            StringResources.currentOffer,
            jobDetails.salary.toString() +
                    ' ' +
                    (jobDetails.currency != null ? jobDetails.currency : '')
          ):SizedBox(),
          jobDetails.salaryMin!=null && jobDetails.salaryMax!=null?jobSummeryRichText(
            StringResources.salaryRangeText,
            (jobDetails.salaryMin != null
                    ? jobDetails.salaryMin.toString()
                    : "") +
                "-" +
                (jobDetails.salaryMax != null
                    ? jobDetails.salaryMax.toString() +
                        ' ' +
                        (jobDetails.currency != null ? jobDetails.currency : '')
                    : ""),
          ):SizedBox()
        ],
      ),
    );
    var otherBenefits = jobDetails.otherBenefits.htmlToNotusDocument.toPlainText().trim().length!=0?Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.gift,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.otherBenefitsTitle,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          HtmlWidget(jobDetails.otherBenefits),
        ],
      ),
    ):SizedBox();
    var jobSummary = Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.list),
            Text(
              StringResources.jobSummeryTitle,
              style: sectionTitleFont,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              //gradient: isDarkMode?AppTheme.darkLinearGradient:AppTheme.lightLinearGradient,
              border: Border.all(width: 1, color: summerySectionBorderColor),
              color: summerySectionColor),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  jobDetails.jobCategory != null?jobSummeryRichText(
                      StringResources.category,
                      jobDetails.jobCategory):SizedBox()
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringResources.vacancy,
                      jobDetails.vacancy != null
                          ? jobDetails.vacancy.toString()
                          : "")
                ],
              ),
              SizedBox(
                height: jobDetails.qualification != null?5:0,
              ),
              jobDetails.qualification != null?Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringResources.qualificationText,
                      jobDetails.qualification)
                ],
              ):SizedBox(),
              SizedBox(
                height: jobDetails.gender != null?5:0,
              ),
              jobDetails.gender != null?Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringResources.gender,
                      jobDetails.gender)
                ],
              ):SizedBox(),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringResources.experience,
                      jobDetails.experience != null
                          ? jobDetails.experience
                          : "")
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        )
      ],
    );
    var requiredSkills = jobDetails.jobSkills.length!=0?Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.tools,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.requiredSkills,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            jobDetails.jobSkills.join(", "),
            style: descriptionFontStyle,
          )
        ],
      ),
    ):SizedBox();

    var benefits = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        salary,
        spaceBetweenSections,
        otherBenefits
      ],
    );

    var benefitsHeader = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              StringResources.benefitSectionTitle,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );

    var betweenDividerSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(FeatherIcons.calendar, size: 14, color: Colors.grey[500]),
            SizedBox(
              width: 5,
            ),
            Text(
              jobDetails.postDate != null
                  ? DateFormatUtil.formatDate(jobDetails.postDate)
                  : "",
              style: topSideDescriptionFontStyle,
            ),
          ],
        ),
        jobDetails.applicationDeadline != null?Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              FeatherIcons.clock,
              size: 14,
              color: Colors.grey[500],
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              DateFormatUtil.formatDate(jobDetails.applicationDeadline),
              style: topSideDescriptionFontStyle,
            ),
          ],
        ):SizedBox(),
      ],
    );

    var jobSource = Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  launch(jobDetails.company.webAddress);
                },
                child: Text(
                  StringResources.jobSource,
                  style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                ))
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringResources.jobDetailsAppBarTitle,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: onOptionSelect,
            itemBuilder: (BuildContext context){
            return options(jobDetails.jobStatus);
          })
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            color: backgroundColor,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      jobHeader,
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sectionColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      betweenDividerSection,
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sectionColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      jobSummary,
                      spaceBetweenSections,
                      aboutJob,
                      spaceBetweenSections,
                      description,
//                      spaceBetweenSections,
                      responsibilities,
//                      spaceBetweenSections,
                      requiredSkills,
                      spaceBetweenSections,
                      education,
//                      spaceBetweenSections,
                      additionalRequirements,
//                      spaceBetweenSections,
                      location,
                      spaceBetweenSections,
                      aboutCompany,
                      spaceBetweenSections,
                      benefitsHeader,
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sectionColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      benefits,
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sectionColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      betweenDividerSection,
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                jobDetails.company.webAddress != null
                    ? Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: sectionColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(3),
                              bottomRight: Radius.circular(3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[jobSource],
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}

