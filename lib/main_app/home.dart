import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/dashboard/view/dash_board_screen.dart';
import 'package:jobxprss_company/main_app/flavour/flavor_banner.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/token_refresh_scheduler.dart';
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

  @override
  void initState() {
    TokenRefreshScheduler.getInstance();
    super.initState();
  }

  _bottomAppbarItem({
    String label,
    @required IconData icon,
    Function onTap,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Icon(icon),
            if (label != null)
              Text(
                label ?? "",
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var bottomAppbar = FABBottomAppBar(
      selectedIndex: currentIndex,
      selectedColor: Theme.of(context).primaryColor,
      notchedShape: CircularNotchedRectangle(),
      centerItemText: StringResources.postText,
      onTap: (int index){
        _paeViewController.animateToPage(index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
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


        //manage candidate
        FABBottomAppBarItem(
            iconData: FontAwesomeIcons.users,
            label: StringResources.manageCandidatesText),
        // shortedListedCandidatesText
        FABBottomAppBarItem(
            iconData: FontAwesomeIcons.solidHeart,
            label: StringResources.shortedListedCandidatesText),
      ],
    );
    var bottomNavBar = BottomNavigationBar(
//        selectedItemColor: Theme.of(context).primaryColor,
//        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          _paeViewController.animateToPage(index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
        currentIndex: currentIndex,
        iconSize: 17,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        items: [
          // dashboard
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: Icon(
                  FontAwesomeIcons.home,
                ),
              ),
              title: Text(StringResources.dashBoardText)),
          //manageJobs
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 3,
                ),
                child: Icon(
                  FontAwesomeIcons.briefcase,
                ),
              ),
              title: Text(StringResources.manageJobsText)),

          //post
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(FontAwesomeIcons.solidPlusSquare),
              ),
              title: Text(StringResources.postText)),
          //manage candidate
          BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(FontAwesomeIcons.users)),
              title: Text(StringResources.manageCandidatesText)),
          // shortedListedCandidatesText
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(FontAwesomeIcons.solidHeart),
              ),
              title: Text(StringResources.shortedListedCandidatesText)),
        ]);

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
          bottomNavigationBar: bottomAppbar,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Post',
            child: Icon(Icons.add),
            elevation: 2.0,
          ),
          body: PageView(
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            controller: _paeViewController,
            children: <Widget>[
              DashBoardScreen(),
              Center(
                child: Text("2"),
              ),
              Center(
                child: Text("3"),
              ),
              Center(
                child: Text("4"),
              ),
              Center(
                child: Text("5"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
