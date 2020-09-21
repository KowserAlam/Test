import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/features/dashboard/view/widgets/info_box_widget.dart';
import 'package:jobxprss_company/features/dashboard/view/widgets/job_chart_widget.dart';
import 'package:jobxprss_company/features/dashboard/view/widgets/profile_complete_parcent_indicatior_widget.dart';
import 'package:jobxprss_company/features/dashboard/view_model/dashboard_view_model.dart';

import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';

import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/root.dart';
import 'package:jobxprss_company/main_app/views/app_drawer.dart';
import 'package:jobxprss_company/main_app/views/widgets/failure_widget.dart';
import 'package:jobxprss_company/main_app/views/widgets/restart_widget.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  final Function onTapFavourite;
  final Function onTapApplied;

  DashBoardScreen({Key key, this.onTapFavourite, this.onTapApplied})
      : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false)
        .getDashboardData(isFormOnPageLoad: true)
        .then((value) {
      if (value == AppError.unauthorized) {
        _signOut(context);
        return;
      }
    });

    var cvm = Provider.of<CompanyProfileViewModel>(context, listen: false);
    if (cvm.company == null) {
      cvm.getCompanyDetails();
    }
  }

  Future<void> _refreshData() async {
    var dbVM = Provider.of<DashboardViewModel>(context, listen: false);
//    var upVM = Provider.of<UserProfileViewModel>(context, listen: false);
    return dbVM.getDashboardData();
  }

  _signOut(context) {
    AuthService.getInstance().then((value) => value.removeUser()).then((value) {
      RestartWidget.restartApp(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var dashboardViewModel = Provider.of<DashboardViewModel>(context);

    errorWidget() {
      switch (dashboardViewModel.infoBoxError) {
        case AppError.serverError:
          return FailureFullScreenWidget(
            errorMessage: StringResources.unableToLoadData,
            onTap: () {
              return _refreshData();
            },
          );

        case AppError.networkError:
          return FailureFullScreenWidget(
            errorMessage: StringResources.couldNotReachServer,
            onTap: () {
              return _refreshData();
            },
          );

        case AppError.unauthorized:
          return FailureFullScreenWidget(
            errorMessage: StringResources.unauthorizedText,
            onTap: () {
              return _signOut(context);
            },
          );

        default:
          return FailureFullScreenWidget(
            errorMessage: StringResources.somethingIsWrong,
            onTap: () {
              return _refreshData();
            },
          );
      }
    }

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
            //dashboardViewModel.shouldShowError
            false
                ? ListView(
                    children: [
                      errorWidget(),
                    ],
                  )
                : ListView(
                    children: [
                      Center(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 720),
                          child: Column(
                            children: [
                              ProfileCompletePercentIndicatorWidget(
                                  dashboardViewModel.profileCompletePercent /
                                      100),
                              InfoBoxWidget(
                                onTapApplications: widget.onTapApplied,
                                onTapShortListed: widget.onTapFavourite,
                              ),
                              JobChartWidget(
                                animate: true,
                              ),
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
