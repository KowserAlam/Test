import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/company_profile/view/company_profile.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/features/dashboard/view/dash_board_screen.dart';
import 'package:jobxprss_company/features/dashboard/view_model/getBottomController.dart';
import 'package:jobxprss_company/features/manage_candidate/view/manage_candidate_screen_all.dart';
import 'package:jobxprss_company/features/manage_jobs/view/manage_jobs_screen.dart';
import 'package:jobxprss_company/features/manage_jobs/view/post_new_job_screen.dart';
import 'package:jobxprss_company/features/manage_jobs/view_models/manages_jobs_view_model.dart';
import 'package:jobxprss_company/features/messaging/view/message_list_screen.dart';
import 'package:jobxprss_company/main_app/flavour/flavor_banner.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/live_update_service.dart';
import 'package:jobxprss_company/main_app/util/token_refresh_scheduler.dart';
import 'package:jobxprss_company/main_app/views/app_drawer.dart';
import 'package:jobxprss_company/main_app/views/widgets/bottom_appbar_fab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _paeViewController = PageController();
  int currentIndex = 0;
  String appbarTitle = StringResources.appName;
  GetStatusControllers getStatusControllers = Get.find();

  @override
  void initState() {
    TokenRefreshScheduler.getInstance();
    Get.put(LiveUpdateService());
    Get.put(ManageJobViewModel());
    Get.put(CompanyProfileViewModel());
    Get.find<LiveUpdateService>().initSocket();
    super.initState();
  }

  _updateAppBar(int index) {
    switch (index) {
      case 0:
        appbarTitle = StringResources.dashBoardText;
        break;
      case 1:
        appbarTitle = StringResources.manageJobsText;
        break;
      case 2:
        appbarTitle = StringResources.manageCandidatesText;
        break;
      case 3:
        appbarTitle = StringResources.companyProfileText;
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    var bottomAppbar = FABBottomAppBar(
      selectedIndex: getStatusControllers.status.value,
      selectedColor: Theme.of(context).primaryColor,
      notchedShape: CircularNotchedRectangle(),
      centerItemText: StringResources.postText,
      onTap: (int index) {
        getStatusControllers.storeStatus(index);
        _updateAppBar(getStatusControllers.status.value);
        print(getStatusControllers.status.value);
      },
      iconSize: 17,
      color: Colors.grey[700],
      items: [
        // dashboard
        FABBottomAppBarItem(
          key: Key('bottomNavBarDashboardKey'),
          iconData: FontAwesomeIcons.home,
          label: StringResources.dashBoardText,
        ),
        //manageJobs
        FABBottomAppBarItem(
          iconData: FontAwesomeIcons.briefcase,
          label: StringResources.manageJobsText,
          key: Key('bottomNavBarManageJobsKey'),
        ),

        //manageCandidatesText
        FABBottomAppBarItem(
          iconData: FontAwesomeIcons.users,
          label: StringResources.candidatesText,
          key: Key('bottomNavBarCandidatesKey'),
        ),
        // profile
        FABBottomAppBarItem(
          iconData: FontAwesomeIcons.solidBuilding,
          label: StringResources.profileText,
          key: Key('bottomNavBarProfileKey'),
        ),
      ],
    );

    var pages = [
      DashBoardScreen(
        onTapJobPosted: () {
          getStatusControllers.storeStatus(1);
        },
        onTapApplications: () {
          getStatusControllers.storeStatus(2);
        },
        onTapShortlisted: () {},
      ),
      ManageJobsScreen(),
      ManageCandidateScreenAll(),
      CompanyProfile(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (getStatusControllers.status.value == 0)
          return true;
        else {
          getStatusControllers.storeStatus(0);
          return false;
        }
      },
      child: FlavorBanner(
        child: Obx((){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                appbarTitle,
                key: Key('appBarTitleKey'),
              ),
              actions: [
                IconButton(
                  key: Key('messageIconButtonOnAppbar'),
                  icon: Icon(FontAwesomeIcons.solidComments),
                  iconSize: 18,
                  onPressed: () {
                    Get.to(MessageListScreen());
                  },
                ),
              ],
            ),
            drawer: AppDrawer(),
            bottomNavigationBar: bottomAppbar,
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              key: Key('PostJobsFloatingActionButtonKey'),
              onPressed: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => PostNewJobScreen()));
              },
              tooltip: 'Post',
              child: Icon(Icons.add),
              elevation: 2.0,
            ),
            body: pages[getStatusControllers.status.value],
          );
        })
      ),
    );
  }
}
