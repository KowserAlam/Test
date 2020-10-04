import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';

class CompanyListTile extends StatefulWidget {
  final Company company;
  CompanyListTile({@required this.company});

  @override
  _CompanyListTileState createState() => _CompanyListTileState();
}

class _CompanyListTileState extends State<CompanyListTile> {
  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    double iconSize = 14.0;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;

    return Container(
      decoration: BoxDecoration(
          color: scaffoldBackgroundColor,
//        borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color:
                Colors.black.withOpacity(0.1),
                blurRadius: 10),
            BoxShadow(
                color:
                Colors.black.withOpacity(0.2),
                blurRadius: 10),
          ]),
      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: backgroundColor,
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color:
                    scaffoldBackgroundColor,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                    widget.company
                        .profilePicture ??
                        "",
                    placeholder: (context, _) =>
                        Image.asset(
                            kCompanyImagePlaceholder),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.company
                              .name ??
                              "",
                          style: titleStyle,
                        ),
//                                                SizedBox(height: 3),
//                                                Text(
//                                                  companySuggestion[index].yearOfEstablishment ?? "",
//                                                  style: TextStyle(color: subtitleColor),
//                                                ),
                        SizedBox(height: 10),
                        if (widget.company
                            .address !=
                            null)
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FeatherIcons.mapPin,
                                  color:
                                  subtitleColor,
                                  size: iconSize,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.company
                                        .address ??
                                        "",
                                    maxLines: 1,
                                    overflow:
                                    TextOverflow
                                        .ellipsis,
                                    style: TextStyle(
                                        color:
                                        subtitleColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    )),
                SizedBox(width: 8),
              ],
            ),
          ),
          SizedBox(height: 1),
          Container(
            padding: EdgeInsets.all(8),
            color: backgroundColor,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      StringResources.companyListYearOfEstablishmentText,
                      style: TextStyle(
                          color: subtitleColor,
                          fontWeight:
                          FontWeight.w600),
                    ),
                    SizedBox(width: 5),
                    Text(
                      widget.company
                          .yearOfEstablishment !=
                          null
                          ? DateFormatUtil.formatDate(
                          widget.company
                              .yearOfEstablishment)
                          : "",
                      style: TextStyle(
                          color: subtitleColor,
                          fontWeight:
                          FontWeight.w100),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
