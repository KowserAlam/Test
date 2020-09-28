import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/certification_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';

class CertificationsSectionWidget extends StatelessWidget {
  final List<CertificationInfo> certificationInfo;

  CertificationsSectionWidget(this.certificationInfo);

  @override
  Widget build(BuildContext context) {
    return UserInfoListItem(
      icon: FontAwesomeIcons.certificate,
      label: StringResources.certificationsText,
      children: List.generate(certificationInfo.length, (index) {
        var cer = certificationInfo[index];
        return CertificationsListItemWidget(
          certificationInfo: cer,
        );
      }),
    );
  }
}

class CertificationsListItemWidget extends StatelessWidget {
  final CertificationInfo certificationInfo;

  const CertificationsListItemWidget({
    Key key,
    this.certificationInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CachedNetworkImage(
          imageUrl: certificationInfo?.organization?.image ?? "",
          height: 60,
          width: 60,
          placeholder: (v, i) => Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Icon(
                FontAwesomeIcons.certificate,
                size: 45,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
        title: Text(
          certificationInfo.certificationName ?? "",
        ),
        subtitle: Text(
          certificationInfo.organizationName ?? "",
        ),
      ),
    );
  }
}
