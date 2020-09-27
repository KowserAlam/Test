import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/view/widgets/job_list_tile_widget.dart';
import 'package:jobxprss_company/features/manage_jobs/view_models/manages_jobs_view_model.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:jobxprss_company/main_app/views/widgets/page_state_builder.dart';
import 'package:provider/provider.dart';

class ManageJobsScreen extends StatefulWidget {
  @override
  _ManageJobsScreenState createState() => _ManageJobsScreenState();
}

class _ManageJobsScreenState extends State<ManageJobsScreen>
{
  ManageJobViewModel jobListViewModel;
  ScrollController _scrollController = ScrollController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {

    jobListViewModel = Get.find<ManageJobViewModel>();
    jobListViewModel.getJobList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        jobListViewModel.getMoreData();
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).backgroundColor;

    return Obx( () {


      return Scaffold(
        key: _scaffoldKey,
        body: PageStateBuilder(
          showLoader: jobListViewModel.showLoader,
          showError: jobListViewModel.showError,
          appError: jobListViewModel.appError.value,
          onRefresh: jobListViewModel.refresh,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            children: [
              (jobListViewModel.jobList.length == 0 &&
                      !jobListViewModel.isFetchingData.value)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(StringResources.noJobsFound),
                      ),
                    )
                  : Center(
                    child: Container(
                        constraints: BoxConstraints(maxWidth: 720),
                        child: _JobListWidget()),
                  ),
            ],
          ),
        ),
      );
    });
  }
}

class _JobListWidget extends StatelessWidget {
  final     jobListViewModel = Get.find<ManageJobViewModel>();
  @override
  Widget build(BuildContext context) {
    var jobList = jobListViewModel.jobList;
    return Obx((){
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 4),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: jobList.length + 1,
          itemBuilder: (context, index) {


            if (index == jobList.length) {
              return Obx((){
                return jobListViewModel.isFetchingMoreData.value
                    ? Padding(padding: EdgeInsets.all(15), child: Loader())
                    : SizedBox();
              });
            }

            JobListModel job = jobList[index];

            return JobListTileWidget(job,index: index,);
          });
    });

  }
}

