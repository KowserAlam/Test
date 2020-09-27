import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_candidate/view/manage_candidate_screen.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/candidate_list_tile.dart';
import 'package:jobxprss_company/features/manage_candidate/view_models/manage_candidate_all_view_model.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_model.dart';
import 'package:jobxprss_company/features/manage_jobs/view_models/manages_jobs_view_model.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';

class ManageCandidateScreenAll extends StatefulWidget {
  @override
  _ManageCandidateScreenAllState createState() =>
      _ManageCandidateScreenAllState();
}

class _ManageCandidateScreenAllState extends State<ManageCandidateScreenAll> {
  final ManageJobViewModel manageJobsVm = Get.find();
  ManageJobCandidateAllViewModel manageJobCandidateAllViewModel;

  @override
  void initState() {
    Get.put(ManageJobCandidateAllViewModel());

    manageJobCandidateAllViewModel = Get.find();
    manageJobsVm.getJobList(pageSize: 100).then((value) {
      if (manageJobCandidateAllViewModel.selectedJob.value?.jobId ==
          null) if (manageJobsVm.jobList.length != 0) {
        manageJobCandidateAllViewModel.selectedJob.value =
            manageJobsVm.jobList[0];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Obx(() {
          if (manageJobsVm.jobList.length == 0) {
            return SizedBox();
          }
          var selected = manageJobCandidateAllViewModel.selectedJob.value;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<JobListModel>(
              selectedItem: selected,
              itemAsString: (v) =>
                  "${v?.title ?? ""} ${v?.appliedCount != null ? "(${v?.appliedCount ?? "0"})" : ""}",
              showSearchBox: true,
              items: manageJobsVm.jobList,
              onChanged: (v) {
                manageJobCandidateAllViewModel.selectedJob.value = v;
              },
            ),
          );
        }),
        Obx(() {
          return manageJobCandidateAllViewModel.selectedJob.value?.jobId != null
              ? Expanded(
              key: Key(manageJobCandidateAllViewModel.selectedJob.value?.jobId),
              child: ManageCandidateScreen(
                manageJobCandidateAllViewModel.selectedJob.value?.jobId,
                showAppBar: false,
              ),)
              : SizedBox();
        }),
        Obx(() {
          return manageJobsVm.showLoader
              ? Expanded(
                  child: Center(
                    child: Loader(),
                  ),
                )
              : SizedBox();
        }),
      ]),
    );
  }
}
