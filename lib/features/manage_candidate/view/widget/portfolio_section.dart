import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/portfolio_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';

class PortfolioSection extends StatelessWidget {
  final List<PortfolioInfo> portfolioInfo;

  PortfolioSection(this.portfolioInfo);

  @override
  Widget build(BuildContext context) {
    return UserInfoListItem(
      icon: FontAwesomeIcons.wallet,
      label: StringResources.projectsText,
      children: List.generate(portfolioInfo.length, (index) {
        var port = portfolioInfo[index];
        return PortfolioListItemWidget(
          portfolioInfo: port,
        );
      }),
    );
  }
}

class PortfolioListItemWidget extends StatefulWidget {
  final PortfolioInfo portfolioInfo;

  const PortfolioListItemWidget({
    Key key,
    @required this.portfolioInfo,
  }) : super(key: key);

  @override
  _PortfolioListItemWidgetState createState() =>
      _PortfolioListItemWidgetState();
}

class _PortfolioListItemWidgetState extends State<PortfolioListItemWidget> {
  bool isExpanded = false;
  int chLength = 150;

  @override
  Widget build(BuildContext context) {
    bool hasMoreText = widget.portfolioInfo.description == null
        ? false
        : widget.portfolioInfo.description.length > chLength;
    String descriptionText = (isExpanded || !hasMoreText)
        ? widget.portfolioInfo?.description ?? ""
        : widget.portfolioInfo?.description?.substring(0, chLength) ?? "";

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 55,
                width: 55,
                imageUrl: widget.portfolioInfo.image ?? "",
                placeholder: (context, _) => Image.asset(
                  kImagePlaceHolderAsset,
                  height: 55,
                  width: 55,
                ),
//          fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.portfolioInfo.name ?? "",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    HtmlWidget(descriptionText,
                        textStyle: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          if (hasMoreText)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: InkWell(
                onTap: () {
                  isExpanded = !isExpanded;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isExpanded
                            ? StringResources.seeLessText
                            : StringResources.seeMoreText,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
