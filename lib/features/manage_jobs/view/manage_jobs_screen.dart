import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/view/widgets/job_list_tile_widget.dart';
import 'package:jobxprss_company/features/manage_jobs/view_models/manages_jobs_view_model.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/failure_widget.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class ManageJobsScreen extends StatefulWidget {
  @override
  _ManageJobsScreenState createState() => _ManageJobsScreenState();
}

class _ManageJobsScreenState extends State<ManageJobsScreen>
    with AfterLayoutMixin {
  ScrollController _scrollController = ScrollController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void afterFirstLayout(BuildContext context) {
    var vm = Provider.of<ManageJobViewModel>(context,listen: false);
    vm.getJobList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        vm.getMoreData();
      }
    });

  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  errorWidget() {
    var jobListViewModel =
    Provider.of<ManageJobViewModel>(context, listen: false);
    switch (jobListViewModel.appError) {
      case AppError.serverError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.unableToLoadData,
          onTap: () {
            return Provider.of<ManageJobViewModel>(context, listen: false)
                .refresh();
          },
        );

      case AppError.networkError:
        return FailureFullScreenWidget(
          errorMessage: StringResources.unableToReachServerMessage,
          onTap: () {
            return Provider.of<ManageJobViewModel>(context, listen: false)
                .refresh();
          },
        );

      case AppError.unauthorized:
        return FailureFullScreenWidget(
          errorMessage: StringResources.somethingIsWrong,
          onTap: () {
//            return _signOut(context);
          },
        );

      default:
        return FailureFullScreenWidget(
          errorMessage: StringResources.somethingIsWrong,
          onTap: () {
            return Provider.of<ManageJobViewModel>(context, listen: false)
                .refresh();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).backgroundColor;

    return Consumer<ManageJobViewModel>(builder: (context, jobListViewModel, _) {

      var jobList = jobListViewModel.jobList;
      var isInSearchMode = jobListViewModel.isInSearchMode;
      var jobListWidget = ListView.builder(
          padding:
          EdgeInsets.symmetric(vertical: 4),
          physics:
          NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: jobList.length + 1,
          itemBuilder: (context, index) {

            if (index == jobList.length) {
              return jobListViewModel
                  .isFetchingMoreData
                  ? Padding(
                  padding:
                  EdgeInsets.all(15),
                  child: Loader())
                  : SizedBox();
            }

            JobListModel job = jobList[index];

            return JobListTileWidget(job);
          });


      return Scaffold(
        key: _scaffoldKey,
        body: RefreshIndicator(
          onRefresh: () async {
            return Provider.of<ManageJobViewModel>(context, listen: false)
                .refresh();
          },
          child: jobListViewModel.shouldShowPageLoader
              ? Center(child: Loader())
              : Container(
            child: jobListViewModel.shouldShowAppError
                ? ListView(
              children: [errorWidget()],
            )
                : ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  children: [

                    (jobListViewModel.jobList.length == 0 &&
                        !jobListViewModel.isFetchingData)
                        ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Text(StringResources.noJobsFound),
                      ),
                    )
                        : jobListWidget,
                  ],
                ),
          ),
        ),
      );
    });
  }
}
