import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

class MessageSenderModel {
  String otherPartyUserId;
  String otherPartyType;
  String otherPartyName;
  String otherPartyImage;

  MessageSenderModel(
      {this.otherPartyUserId,
        this.otherPartyType,
        this.otherPartyName,
        this.otherPartyImage});

  MessageSenderModel.fromJson(Map<String, dynamic> json) {
    var baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    otherPartyUserId = json['other_party_user_id']?.toString();
    otherPartyType = json['other_party_type'];
    otherPartyName = json['other_party_name'];

    otherPartyImage = "$baseUrl${json['other_party_image']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['other_party_user_id'] = this.otherPartyUserId;
    data['other_party_type'] = this.otherPartyType;
    data['other_party_name'] = this.otherPartyName;
    data['other_party_image'] = this.otherPartyImage;
    return data;
  }
}
