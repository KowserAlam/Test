import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/features/company_profile/repositories/company_repository.dart';
import 'package:jobxprss_company/features/settings/settings_screen.dart';
import 'package:jobxprss_company/features/settings/settings_view_model.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/locator.dart';
import 'package:jobxprss_company/main_app/views/about_us_screen.dart';
import 'package:jobxprss_company/main_app/views/contact_us_screen.dart';
import 'package:jobxprss_company/main_app/views/faq_screen.dart';
import 'package:jobxprss_company/main_app/views/widgets/app_version_widget_small.dart';

class AppDrawer extends StatefulWidget {
  final String routeName;

  AppDrawer({this.routeName});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var selectedIndex = 0;
  var navBarTextColor = Colors.white;

  @override
  void initState() {
//    Future.delayed(Duration.zero).then((value) {
//      var upvm = Provider.of<UserProfileViewModel>(context,listen: false);
//      var user = upvm?.userData?.personalInfo;
//      if (user == null) {
//        upvm.getUserData();
//      }
//    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var headerBackgroundColor = Color(0xff08233A);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: headerBackgroundColor,
              image: DecorationImage(
                  image: AssetImage(kUserProfileCoverImageAsset),
                  fit: BoxFit.cover),
            ),
            child: FutureBuilder<Company>(
                future: CompanyRepository().getCompanyFromLocalStorage(),
                builder: (context, AsyncSnapshot<Company> snapshot) {
                  var company = snapshot.data;

                  var imageUrl = company?.profilePicture ?? "";
                  return Container(
                    height: 160,
//                  decoration: BoxDecoration(
//                    color: headerBackgroundColor,
//                    image: DecorationImage(
//                        image: AssetImage(kUserProfileCoverImageAsset),
//                        fit: BoxFit.cover),
//                  ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.settings,
                              ),
                              color: navBarTextColor,
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => ConfigScreen()));
                              },
                            ),
                            Container(
                              child: IconButton(
                                icon: Icon(Icons.menu),
                                color: navBarTextColor,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        //profile image
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context)
                                  .backgroundColor
                                  .withOpacity(0.8)),
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, _) => Image.asset(
                                kCompanyImagePlaceholder,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          company?.name ?? "",
                          style:
                              TextStyle(color: navBarTextColor, fontSize: 18),
                        ),
                        Text(
                          company?.email ?? "",
                          style: TextStyle(color: navBarTextColor),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(height: 1),
//                  //companyProfile
//                  DrawerListWidget(
//                    label: StringResources.companyProfileText,
//                    icon: FontAwesomeIcons.solidBuilding,
//                    isSelected: false,
//                    onTap: () {
//                      Navigator.pop(context);
//                      Navigator.of(context).push(CupertinoPageRoute(
//                          builder: (context) => CompanyDetails()));
//                    },
//                  ),
//                  Divider(height: 1),
                  //about us
                  // DrawerListWidget(
                  //   label: StringResources.aboutUsText,
                  //   icon: FontAwesomeIcons.infoCircle,
                  //   isSelected: false,
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.of(context).push(CupertinoPageRoute(
                  //         builder: (context) => AboutUsScreen()));
                  //   },
                  // ),
                  // Divider(height: 1),
                  // //contact us
                  // DrawerListWidget(
                  //   label: StringResources.contactUsText,
                  //   icon: FontAwesomeIcons.at,
                  //   isSelected: false,
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.of(context).push(CupertinoPageRoute(
                  //         builder: (context) => ContactUsScreen()));
                  //   },
                  // ),
                  //
                  // Divider(height: 1),
                  // //faq
                  // DrawerListWidget(
                  //   label: StringResources.faqText,
                  //   icon: FontAwesomeIcons.questionCircle,
                  //   isSelected: false,
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.of(context).push(CupertinoPageRoute(
                  //         builder: (context) => FAQScreen()));
                  //   },
                  // ),
                  // Divider(height: 1),

                  /// ************ sign out
                  DrawerListWidget(
                    label: StringResources.signOutText,
                    icon: FontAwesomeIcons.signOutAlt,
                    isSelected: false,
                    onTap: () {
                      _handleSignOut(context);
                    },
                  ),
                  Divider(height: 1),
                ],
              ),
            ),
          ),
          Center(child: AppVersionWidgetLowerCase())
        ],
      ),
    );
  }
}

_handleSignOut(context) {
//  Provider.of<LoginViewModel>(context, listen: false).signOut();
//  Provider.of<JobListViewModel>(context, listen: false).resetState();
//  Provider.of<FavouriteJobListViewModel>(context, listen: false).resetState();
//  Provider.of<AppliedJobListViewModel>(context, listen: false).resetState();
//  Provider.of<JobListFilterWidgetViewModel>(context, listen: false)
//      .resetState();
//  Provider.of<UserProfileViewModel>(context, listen: false).resetState();

  // AuthService.getInstance().then((value) => value.removeUser()).then((value) {
  //   RestartWidget.restartApp(context);
  // });

  locator<SettingsViewModel>().signOut();
}

/// App Drawer item widget
class DrawerListWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Function onTap;
  final Color color;

  DrawerListWidget({
    @required this.icon,
    @required this.label,
    this.color,
    this.isSelected = false,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var iconColor = color ??
        (isSelected
            ? Theme.of(context).primaryColor
            : (isDarkMode ? Colors.grey[200] : Colors.grey[700]));
    return Material(
      color: isSelected
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Container(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).scaffoldBackgroundColor,
              width: 4,
              height: AppBar().preferredSize.height / 1.2,
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 17,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: color),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
