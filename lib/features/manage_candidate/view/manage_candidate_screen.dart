import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/candidate_list_tile.dart';
import 'package:jobxprss_company/features/manage_candidate/view_models/manage_candidate_view_model.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/failure_widget.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:jobxprss_company/main_app/views/widgets/page_state_builder.dart';
import 'package:provider/provider.dart';

class ManageCandidateScreen extends StatefulWidget {
  final String jobId;

  ManageCandidateScreen(this.jobId);

  @override
  _ManageCandidateScreenState createState() => _ManageCandidateScreenState();
}

class _ManageCandidateScreenState extends State<ManageCandidateScreen>
    with AfterLayoutMixin {
  ManageCandidateVewModel _vm;

  @override
  void initState() {
    _vm = ManageCandidateVewModel();
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _vm.getData(widget.jobId);
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      key: Key(widget.jobId),
      create: (context) => _vm,
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringResources.manageCandidatesText),
        ),
        body: Consumer<ManageCandidateVewModel>(
          builder: (BuildContext context, manageCandidateVm, Widget child) {
            var candidates = manageCandidateVm.candidates;

            return PageStateBuilder(
              onRefresh: manageCandidateVm.refresh,
              showError: manageCandidateVm.showError,
              appError: manageCandidateVm.appError,
              showLoader: manageCandidateVm.showLoader,
              child: ListView.builder(
                  itemCount: candidates.length,
                  itemBuilder: (BuildContext context, int index) {
                    Candidate candidate = candidates[index];
                    return CandidateListTile(candidate);
                  }),
            );
          },
        ),
      ),
    );
  }
}


