import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';

class NoApplicationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FeatherIcons.fileText,
              color: Colors.grey,
              size: 100,
            ),
            SizedBox(height: 10,),
            Text(
              StringResources.noApplicationsText,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
