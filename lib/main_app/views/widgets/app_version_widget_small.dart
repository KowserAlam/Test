
import 'package:jobxprss_company/main_app/repositories/app_info_repository.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:flutter/material.dart';

class AppVersionWidgetSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: AppInfoRepository().getAppVersion(),
        builder: (c,snapshot){
          if(snapshot.hasData){
            return Text("${StringResources.versionText}: ${snapshot.data}",style: TextStyle(color: Colors.grey),);
          }
          return SizedBox();
        },
      ),
    );
  }
}

class AppVersionWidgetLowerCase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: AppInfoRepository().getAppVersion(),
        builder: (c,snapshot){
          if(snapshot.hasData){
            return Text("${StringResources.versionTextLowerCase}${snapshot.data}",style: TextStyle(color: Colors.grey),);
          }
          return SizedBox();
        },
      ),
    );
  }
}
