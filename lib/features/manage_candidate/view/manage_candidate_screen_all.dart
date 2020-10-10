import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_candidate/view/manage_candidate_screen.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/candidate_list_tile.dart';
import 'package:jobxprss_company/features/manage_candidate/view_models/manage_candidate_all_view_model.dart';
import 'package:jobxprss_company/features/manage_candidate/view_models/manage_candidate_view_model.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_model.dart';
import 'package:jobxprss_company/features/manage_jobs/view_models/manages_jobs_view_model.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';

class ManageCandidateScreenAll extends StatefulWidget {
  @override
  _ManageCandidateScreenAllState createState() =>
      _ManageCandidateScreenAllState();
}

class _ManageCandidateScreenAllState extends State<ManageCandidateScreenAll> {
  final ManageJobViewModel manageJobsVm = Get.find();
  final ManageCandidateVewModel manageCandidateVM = Get.put(ManageCandidateVewModel());
  ManageJobCandidateAllViewModel manageJobCandidateAllViewModel;
  bool isShortListed = false;

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
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
            decoration: BoxDecoration(
              borderRadius: CommonStyle.borderRadius,
                color: Theme.of(context).backgroundColor,
              boxShadow: CommonStyle.boxShadow
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: DropdownSearch<JobListModel>(
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4),
                ),
                selectedItem: selected,
                itemAsString: (v) =>
                    "${v?.title ?? ""} ${v?.appliedCount != null ? "(${v?.appliedCount ?? "0"})" : ""}",
                showSearchBox: true,
                items: manageJobsVm.jobList,
                onChanged: (v) {
                  manageJobCandidateAllViewModel.selectedJob.value = v;
                },
              ),
            ),
          );
        }),
        Obx((){
          return manageJobCandidateAllViewModel.selectedJob.value?.jobId != null?
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Shortlisted Only'),
              Checkbox(value: isShortListed, onChanged: (v){setState(() {
                isShortListed = v;
              });})
            ],
          ):SizedBox();
        }),
        Obx(() {
          return manageJobCandidateAllViewModel.selectedJob.value?.jobId != null
              ? Expanded(
            key: Key(manageJobCandidateAllViewModel.selectedJob.value?.jobId),
            child: ManageCandidateScreen(
              manageJobCandidateAllViewModel.selectedJob.value?.jobId,
              isShortListed,
              showAppBar: false,
            ),)
              : SizedBox();
        }),
        Obx(() {
          return manageCandidateVM.showLoader
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
