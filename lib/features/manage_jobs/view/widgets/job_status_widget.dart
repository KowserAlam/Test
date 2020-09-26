import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';

class JobStatusWidget extends StatelessWidget {
  final JobStatus jobStatus;
  final bool isExpired;

  JobStatusWidget(this.jobStatus, this.isExpired);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.orange;
    var status = jobStatus;
    String text = "POSTED";

    switch (status) {
      case JobStatus.POSTED:
        color = Colors.blue;
        break;
      case JobStatus.DRAFT:
        text = "DRAFT";
        color = Colors.purple;
        break;
      case JobStatus.UNPUBLISHED:
        text = "UNPUBLISHED";
        color = Colors.grey;
        break;
      case JobStatus.PUBLISHED:

        color = Colors.green;
        text = "PUBLISHED";

        break;
    }
//    if (isExpired) {
//      text = "Expired";
//      color = Colors.red;
//    }

    return Container(
      child: Text(text,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: color)),
    );
  }
}
