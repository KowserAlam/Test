import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/company_profile/view/company_profile.dart';
import 'package:jobxprss_company/features/dashboard/view/dash_board_screen.dart';
import 'package:jobxprss_company/features/manage_jobs/view/post_new_job_screen.dart';
import 'package:jobxprss_company/features/manage_candidate/view/manage_candidate_screen.dart';
import 'package:jobxprss_company/features/manage_jobs/view/manage_jobs_screen.dart';
import 'package:jobxprss_company/features/messaging/view/message_list_screen.dart';
import 'package:jobxprss_company/main_app/flavour/flavor_banner.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/token_refresh_scheduler.dart';
import 'package:jobxprss_company/main_app/views/app_drawer.dart';
import 'package:jobxprss_company/main_app/views/widgets/bottom_appbar_fab.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _paeViewController = PageController();
  int currentIndex = 0;
  String appbarTitle = StringResources.appName;

  @override
  void initState() {
    TokenRefreshScheduler.getInstance();
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

  _modeToPage(int index) async {
    if (currentIndex != index) {
      var offset = 0;

      if (index > currentIndex) {
        offset = 300;
      } else if (index < currentIndex) {
        offset = -300;
      }
      await _paeViewController.animateTo(_paeViewController.offset + offset,
          duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);
      _paeViewController.jumpToPage(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    var bottomAppbar = FABBottomAppBar(
      selectedIndex: currentIndex,
      selectedColor: Theme.of(context).primaryColor,
      notchedShape: CircularNotchedRectangle(),
      centerItemText: StringResources.postText,
      onTap: (int index) {
        _modeToPage(index);
      },
      iconSize: 17,
      color: Colors.grey[700],
      items: [
        // dashboard
        FABBottomAppBarItem(
            iconData: FontAwesomeIcons.home,
            label: StringResources.dashBoardText),
        //manageJobs
        FABBottomAppBarItem(
            iconData: FontAwesomeIcons.briefcase,
            label: StringResources.manageJobsText),

        //manageCandidatesText
        FABBottomAppBarItem(
            iconData: FontAwesomeIcons.users,
            label: StringResources.candidatesText),
        // profile
        FABBottomAppBarItem(
            iconData: FontAwesomeIcons.solidBuilding,
            label: StringResources.profileText),
      ],
    );
//    var bottomNavBar = BottomNavigationBar(
////        selectedItemColor: Theme.of(context).primaryColor,
////        unselectedItemColor: Colors.grey,
//        onTap: (int index) {
//          _paeViewController.animateToPage(index,
//              duration: const Duration(milliseconds: 400),
//              curve: Curves.easeInOut);
//        },
//        currentIndex: currentIndex,
//        iconSize: 17,
//        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
//        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
//        selectedFontSize: 10,
//        unselectedFontSize: 10,
//        type: BottomNavigationBarType.fixed,
//        items: [
//          // dashboard
//          BottomNavigationBarItem(
//              icon: Padding(
//                padding: const EdgeInsets.only(
//                  bottom: 3,
//                ),
//                child: Icon(
//                  FontAwesomeIcons.home,
//                ),
//              ),
//              title: Text(StringResources.dashBoardText)),
//          //manageJobs
//          BottomNavigationBarItem(
//              icon: Padding(
//                padding: const EdgeInsets.only(
//                  bottom: 3,
//                ),
//                child: Icon(
//                  FontAwesomeIcons.briefcase,
//                ),
//              ),
//              title: Text(StringResources.manageJobsText)),
//
//          //post
//          BottomNavigationBarItem(
//              icon: Padding(
//                padding: const EdgeInsets.only(bottom: 5),
//                child: Icon(FontAwesomeIcons.solidPlusSquare),
//              ),
//              title: Text(StringResources.postText)),
//          //manage candidate
//          BottomNavigationBarItem(
//              icon: Padding(
//                  padding: const EdgeInsets.only(bottom: 5),
//                  child: Icon(FontAwesomeIcons.users)),
//              title: Text(StringResources.candidatesText)),
//          // shortedListedCandidatesText
//          BottomNavigationBarItem(
//              icon: Padding(
//                padding: const EdgeInsets.only(bottom: 5),
//                child: Icon(FontAwesomeIcons.solidHeart),
//              ),
//              title: Text(StringResources.shortedListedText)),
//        ]);

    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0)
          return true;
        else {
          _paeViewController.animateToPage(0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
          return false;
        }
      },
      child: FlavorBanner(
        child: Scaffold(
          appBar: AppBar(
            title: Text(appbarTitle),
            actions: [
              IconButton(
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
            onPressed: () {
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => PostNewJobScreen()));
            },
            tooltip: 'Post',
            child: Icon(Icons.add),
            elevation: 2.0,
          ),
          body: PageView(
            onPageChanged: (index) {
              _updateAppBar(index);
              setState(() {
                currentIndex = index;
              });
            },
            controller: _paeViewController,
            children: <Widget>[
              DashBoardScreen(),
              ManageJobsScreen(),
//              ManageCandidateScreen(),
              Center(child: Text(StringResources.manageCandidatesText),),
              CompanyProfile(),
            ],
          ),
        ),
      ),
    );
  }
}
