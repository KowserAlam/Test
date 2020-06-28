import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/models/candidate.dart';

class CandidateListTile extends StatelessWidget {
  final Candidate candidate;

  CandidateListTile(this.candidate);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;
    var backgroundColor = Theme.of(context).backgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    var titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    var subTitleStyle = TextStyle(fontSize: 12, color: subtitleColor);
    double iconSize = 12;

    var name = Text(candidate.fullName ?? "");

    var dateOfBirth = Text(
      "${candidate.dateOfBirth ?? ""}",
      style: subTitleStyle,
    );
    var qualification = Text(
      "${candidate.qualification ?? ""}",
      style: subTitleStyle,
    );
    var experience = Text(
      "${candidate.experience ?? ""} Year experience",
      style: subTitleStyle,
    );
    var profileImage = Container(
      height: 60,
      width: 60,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: candidate.image ?? "",
      ),
    );

    return Container(
      decoration: BoxDecoration(color: scaffoldBackgroundColor, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 17),
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 17),
      ]),
      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        profileImage,
                        SizedBox(width: 5,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            name,
                            qualification,
                            experience,
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Job Title
              Divider(height: 1),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
