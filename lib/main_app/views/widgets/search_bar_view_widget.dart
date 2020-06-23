import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:flutter/material.dart';

class SearchBarViewWidget extends StatelessWidget {
  final Function onTap;

  SearchBarViewWidget({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).backgroundColor),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              StringResources.searchText,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
