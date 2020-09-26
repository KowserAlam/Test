import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/candidate_list_tile.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/no_application_widget.dart';
import 'package:jobxprss_company/features/manage_candidate/view_models/manage_candidate_view_model.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/page_state_builder.dart';
import 'package:provider/provider.dart';

class ManageCandidateScreen extends StatefulWidget {
  final String jobId;

  ManageCandidateScreen(this.jobId);

  @override
  _ManageCandidateScreenState createState() => _ManageCandidateScreenState();
}

class _ManageCandidateScreenState extends State<ManageCandidateScreen>{
  ManageCandidateVewModel manageCandidateVm;

  @override
  void initState() {
    Get.put(ManageCandidateVewModel(),tag: widget.jobId,permanent: true);
    manageCandidateVm = Get.find<ManageCandidateVewModel>(tag:widget.jobId );
    manageCandidateVm.getData(widget.jobId);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.manageCandidatesText),
      ),
      body: Obx((){
        var candidates = manageCandidateVm.candidates;
        return PageStateBuilder(
          onRefresh: ()=>manageCandidateVm.refresh(widget.jobId),
          showError: manageCandidateVm.showError,
          appError: manageCandidateVm.appError,
          showLoader: manageCandidateVm.showLoader,
          child:
          candidates.length == 0? NoApplicationWidget():
          ListView.builder(
              itemCount: candidates.length,
              itemBuilder: (BuildContext context, int index) {
                Candidate candidate = candidates[index];
                return CandidateListTile(candidate,index: index,jobId: widget.jobId,);
              }),
        );
      }),
    );
  }
}


