import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

class ConversationScreenDataModel {
  int count;
  Pages pages;
  List<Message> messages;

  ConversationScreenDataModel({this.count, this.pages, this.messages});

  ConversationScreenDataModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'] != null ? new Pages.fromJson(json['pages']) : null;
    if (json['results'] != null) {
      messages = new List<Message>();
      json['results'].forEach((v) {
        messages.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.pages != null) {
      data['pages'] = this.pages.toJson();
    }
    if (this.messages != null) {
      data['results'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pages {
  bool previousUrl;
  bool nextUrl;

  Pages({this.previousUrl, this.nextUrl});

  Pages.fromJson(Map<String, dynamic> json) {
    previousUrl = json['previous_url']!= null;
    nextUrl = json['next_url'] != null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['previous_url'] = this.previousUrl;
    data['next_url'] = this.nextUrl;
    return data;
  }
}

class Message {
  String message;
  int receiver;
  String receiverType;
//  ReceiverCompany receiverCompany;
 ReceiverPro receiverPro;
  int sender;
  String senderType;
//  ReceiverCompany senderCompany;
 ReceiverPro senderPro;
  DateTime createdAt;

  Message(
      {this.message,
        this.receiver,
        this.receiverType,
//        this.receiverCompany,
//        this.receiverPro,
        this.sender,
        this.senderType,
//        this.senderCompany,
       this.senderPro,
        this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    receiver = json['receiver'];
    receiverType = json['receiver_type'];
//    receiverCompany = json['receiver_company'] != null
//        ? new ReceiverCompany.fromJson(json['receiver_company'])
//        : null;
//    receiverPro = json['receiver_pro'] != null
//        ? new ReceiverPro.fromJson(json['receiver_pro'])
//        : null;
    sender = json['sender'];
    senderType = json['sender_type'];
//    senderCompany = json['sender_company'] != null
//        ? new ReceiverCompany.fromJson(json['sender_company'])
//        : null;
   senderPro = json['sender_pro'] != null
       ? new ReceiverPro.fromJson(json['sender_pro'])
       : null;
    if(json['created_at'] != null){
      createdAt = DateTime.parse(json['created_at']);
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['receiver'] = this.receiver;
    data['receiver_type'] = this.receiverType;
//    if (this.receiverCompany != null) {
//      data['receiver_company'] = this.receiverCompany.toJson();
//    }
//    if (this.receiverPro != null) {
//      data['receiver_pro'] = this.receiverPro.toJson();
//    }
    data['sender'] = this.sender;
    data['sender_type'] = this.senderType;
//    if (this.senderCompany != null) {
//      data['sender_company'] = this.senderCompany.toJson();
//    }
//    if (this.senderPro != null) {
//      data['sender_pro'] = this.senderPro.toJson();
//    }
    data['created_at'] = this.createdAt;
    return data;
  }

  @override
  String toString() {
    return 'Message{message: $message, receiver: $receiver, receiverType: $receiverType, sender: $sender, senderType: $senderType, createdAt: $createdAt}';
  }
}

class ReceiverCompany {
  String name;
  String profilePicture;

  ReceiverCompany({this.name, this.profilePicture});

  ReceiverCompany.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}

class ReceiverPro {
  String fullName;
  String image;

  ReceiverPro({this.fullName, this.image});

  ReceiverPro.fromJson(Map<String, dynamic> json) {
    var baseUrl = FlavorConfig.instance.values.baseUrl;
    fullName = json['full_name'];
    image = "$baseUrl${json['image']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    return data;
  }
}
