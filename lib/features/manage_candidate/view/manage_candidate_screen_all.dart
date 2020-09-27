import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_model.dart';
import 'package:jobxprss_company/features/manage_jobs/view_models/manages_jobs_view_model.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';

class ManageCandidateScreenAll extends StatefulWidget {
  @override
  _ManageCandidateScreenAllState createState() => _ManageCandidateScreenAllState();
}

class _ManageCandidateScreenAllState extends State<ManageCandidateScreenAll> {
  final ManageJobViewModel manageJobsVm = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
         ListView(children: [

           Obx((){
             return DropdownSearch<JobListModel>(
               itemAsString: (v)=>v.title,
               showSearchBox: true,
               items: manageJobsVm.jobList,
             );
           }),

      ]),
    );
  }
}
