import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/manage_candidate/view_models.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
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
            return ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (BuildContext context,int index){
                  Candidate candidate = candidates[index];
              return ListTile(
                leading: CachedNetworkImage(imageUrl: candidate.image??"",),
                title: Text(candidate.fullName??""),);
            });
          },
        ),
      ),
    );
  }
}
