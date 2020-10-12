import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/candidate_list_tile.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/no_application_widget.dart';
import 'package:jobxprss_company/features/manage_candidate/view_models/manage_candidate_view_model.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/page_state_builder.dart';

class ManageCandidateScreen extends StatefulWidget {
  final String jobId;
  final showAppBar;
  final bool isShortListed;

  ManageCandidateScreen(this.jobId,this.isShortListed,{this.showAppBar = true});

  @override
  _ManageCandidateScreenState createState() => _ManageCandidateScreenState(jobId);
}

class _ManageCandidateScreenState extends State<ManageCandidateScreen> {
  ManageCandidateVewModel manageCandidateVm;
  bool isShortListed = false;
  _ManageCandidateScreenState(String jobId){
    Get.put(ManageCandidateVewModel(),tag: jobId);

    manageCandidateVm = Get.find<ManageCandidateVewModel>(tag:jobId);
    manageCandidateVm.getData(jobId);
    manageCandidateVm.getDataShortlisted(jobId);
  }


  // @override
  // void initState() {
  //
  //   super.initState();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar?AppBar(
        title: Text(StringResources.manageCandidatesText, key: Key('manageCandidatesAppBarTextKey'),),
      ):null,
      body: widget.showAppBar?Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Shortlisted Only'),
              Checkbox(value: isShortListed, onChanged: (v){setState(() {
                isShortListed = v;
              });})
            ],
          ),
          Expanded(
            child: Obx((){
              var candidates = manageCandidateVm.toggleShortListed(isShortListed);
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
          )
        ],
      ):Obx((){
        var candidates = manageCandidateVm.toggleShortListed(widget.isShortListed);
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


