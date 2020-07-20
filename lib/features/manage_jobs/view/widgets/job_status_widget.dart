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
    String text = "Pending";

    switch (status) {
      case JobStatus.NOT_READY:

        break;
      case JobStatus.RAW:

        break;
      case JobStatus.DRAFT:
         text = "Draft";

        break;
      case JobStatus.REVIEWED:


        break;
      case JobStatus.APPROVED:
        break;
      case JobStatus.PUBLISHED:

        if(isExpired){
          text = "Expired";
          color = Colors.red;
        }else{
          text = "Active";
          color = Colors.green;
        }

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
