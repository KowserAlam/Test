import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as dartZ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/company_profile/view/company_profile.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_model.dart';
import 'package:jobxprss_company/features/manage_jobs/repositories/job_repository.dart';
import 'package:jobxprss_company/main_app/api_helpers/url_launcher_helper.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/failure_widget.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jobxprss_company/method_extension.dart';

class JobDetails extends StatefulWidget {
  final String slug;

  JobDetails(this.slug);

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
    print(widget.slug);
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

  String skillListToString() {
    String listOfSkills = "";
    if (jobDetails.jobSkills != null)
      for (int i = 0; i < jobDetails.jobSkills.length; i++) {
        if (i + 1 == jobDetails.jobSkills.length) {
          listOfSkills += jobDetails.jobSkills[i];
        } else {
          listOfSkills += jobDetails.jobSkills[i] + ", ";
        }
      }
    return listOfSkills;
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
        await JobRepository().fetchJobDetails(widget.slug);
    return result.fold((l) {
      _isBusy = false;
      _appError = l;
      setState(() {});
      print(l);
    }, (JobModel dataModel) {
      print(dataModel.title);
      jobDetails = dataModel;
      _isBusy = false;
      setState(() {});
    });
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
////      print(l);
////    }, (List<Company> dataModel) {
////      print(dataModel[0].name);
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
//print(jobDetails?.company?.profilePicture);
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
                              : StringResources.noneText,
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
                    GestureDetector(
                      child: Text(
                        jobDetails.company != null
                            ? jobDetails.company.name
                            : StringResources.noneText,
                        style: jobDetails.company == null
                            ? topSideDescriptionFontStyle
                            : hasCompanyFontStyle,
                      ),
                      onTap: () {
                        jobDetails.company != null
                            ? Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => CompanyProfile()))
                            : null;
                      },
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
    var description = Container(
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
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            jobDetails.descriptions != null
                ? jobDetails.descriptions
                : StringResources.noneText,
            style: descriptionFontStyle,
          )
        ],
      ),
    );
    var responsibilities = Container(
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
          Text(
            jobDetails.responsibilities != null
                ? jobDetails.responsibilities
                : StringResources.noneText,
            style: descriptionFontStyle,
          )
        ],
      ),
    );
    var education = Container(
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
          Text(
            jobDetails.education != null
                ? jobDetails.education
                : StringResources.noneText,
            style: descriptionFontStyle,
          )
        ],
      ),
    );

    var additionalRequirements = Container(
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
          Text(
            jobDetails.additionalRequirements != null
                ? jobDetails.additionalRequirements
                : StringResources.noneText,
            style: descriptionFontStyle,
          )
        ],
      ),
    );

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
                  : StringResources.noneText),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringResources.jobAreaText,
              jobDetails.jobArea != null
                  ? jobDetails.jobArea
                  : StringResources.noneText),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringResources.jobCityText,
              jobDetails.jobCity != null
                  ? jobDetails.jobCity
                  : StringResources.noneText),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringResources.jobCountryText,
              jobDetails.jobCountry != null
                  ? jobDetails.jobCountry
                  : StringResources.noneText),
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
                  : StringResources.noneText),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringResources.jobNature,
              jobDetails.jobNature != null
                  ? refactorAboutJobStrings(jobDetails.jobNature)
                  : StringResources.noneText),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringResources.jobSiteText,
              jobDetails.jobSite != null
                  ? refactorAboutJobStrings(jobDetails.jobSite)
                  : StringResources.noneText),
          SizedBox(
            height: 5,
          ),
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
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                StringResources.jobCompanyProfileText + ': ',
                style: descriptionFontStyleBold,
              ),
              jobDetails.companyProfile != null
                  ? GestureDetector(
                      onTap: () {
                        UrlLauncherHelper.launchUrl(
                            jobDetails.companyProfile.trim());
                      },
                      child: Text(
                        jobDetails.companyProfile,
                        style: TextStyle(color: Colors.lightBlue),
                      ))
                  : Text(StringResources.noneText),
            ],
          ),
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
          jobSummeryRichText(
            StringResources.currentOffer,
            jobDetails.salary != null
                ? jobDetails.salary.toString() +
                    ' ' +
                    (jobDetails.currency != null ? jobDetails.currency : '')
                : StringResources.noneText,
          ),
          jobSummeryRichText(
            StringResources.salaryRangeText,
            (jobDetails.salaryMin != null
                    ? jobDetails.salaryMin.toString()
                    : StringResources.noneText) +
                "-" +
                (jobDetails.salaryMax != null
                    ? jobDetails.salaryMax.toString() +
                        ' ' +
                        (jobDetails.currency != null ? jobDetails.currency : '')
                    : StringResources.noneText),
          )
        ],
      ),
    );
    var otherBenefits = Container(
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
          Text(
            jobDetails.otherBenefits != null
                ? jobDetails.otherBenefits
                : StringResources.noneText,
            style: descriptionFontStyle,
          )
        ],
      ),
    );
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
                  jobSummeryRichText(
                      StringResources.category,
                      jobDetails.jobCategory != null
                          ? jobDetails.jobCategory
                          : StringResources.noneText)
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
                          : StringResources.noneText)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringResources.qualificationText,
                      jobDetails.qualification != null
                          ? jobDetails.qualification
                          : StringResources.noneText)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringResources.gender,
                      jobDetails.gender != null
                          ? jobDetails.gender
                          : StringResources.noneText)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringResources.experience,
                      jobDetails.experience != null
                          ? jobDetails.experience
                          : StringResources.noneText)
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
    var requiredSkills = Container(
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
            skillListToString(),
            style: descriptionFontStyle,
          )
        ],
      ),
    );

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
                  : StringResources.noneText,
              style: topSideDescriptionFontStyle,
            ),
          ],
        ),
        Row(
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
              jobDetails.applicationDeadline != null
                  ? DateFormatUtil.formatDate(jobDetails.applicationDeadline)
                  : StringResources.noneText,
              style: topSideDescriptionFontStyle,
            ),
          ],
        ),
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
                      spaceBetweenSections,
                      responsibilities,
                      spaceBetweenSections,
                      requiredSkills,
                      spaceBetweenSections,
                      education,
                      spaceBetweenSections,
                      additionalRequirements,
                      spaceBetweenSections,
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
