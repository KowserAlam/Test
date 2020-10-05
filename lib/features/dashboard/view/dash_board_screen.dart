import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/features/dashboard/values.dart';
import 'package:jobxprss_company/features/dashboard/view/widgets/info_box_widget.dart';
import 'package:jobxprss_company/features/dashboard/view/widgets/job_chart_widget.dart';
import 'package:jobxprss_company/features/dashboard/view/widgets/other_screens_widget.dart';
import 'package:jobxprss_company/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/app_drawer.dart';
import 'package:jobxprss_company/main_app/views/widgets/failure_widget.dart';
import 'package:jobxprss_company/main_app/views/widgets/restart_widget.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  final Function onTapShortlisted;
  final Function onTapApplications;
  final Function onTapJobPosted;

  DashBoardScreen(
      {Key key,
      this.onTapShortlisted,
      this.onTapApplications,
      this.onTapJobPosted})
      : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  var _ = Get.put(DashboardViewModel());
  DashboardViewModel vm =  Get.find<DashboardViewModel>();


  @override
  void initState() {


   vm.getDashboardData().then((value) {
      if (value == AppError.unauthorized) {
        _signOut(context);
        return;
      }
    });

    var cvm = Get.find<CompanyProfileViewModel>();
    if (cvm.company == null) {
      cvm.getCompanyDetails();
    }
    super.initState();
  }

  Future<void> _refreshData() async {
    return vm.getDashboardData();
  }

  _signOut(context) {
    AuthService.getInstance().then((value) => value.removeUser()).then((value) {
      RestartWidget.restartApp(context);
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
//      appBar: AppBar(
//        title: Text(StringResources.dashBoardText),
//        actions: [
////          IconButton(
////            icon: Icon(FontAwesomeIcons.solidComment),
////            onPressed: () {
////              Navigator.of(context).push(CupertinoPageRoute(
////                  builder: (BuildContext context) => MessageScreen()));
////            },
////          )
//        ],
//      ),
      drawer: AppDrawer(
        routeName: 'dashboard',
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child:
         ListView(
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          constraints: BoxConstraints(maxWidth: 720),
                          child: Column(
                            children: [
                              DashboardValues.sizedBoxBetweenSection,
                              InfoBoxWidget(
                                onTapApplications: widget.onTapApplications,
                                onTapShortListed: widget.onTapShortlisted,
                                onTapJobPosted: widget.onTapJobPosted,
                              ),
                              DashboardValues.sizedBoxBetweenSection,
                              JobChartWidget(),
                              DashboardValues.sizedBoxBetweenSection,
                              OtherScreensWidget(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
