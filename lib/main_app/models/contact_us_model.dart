class ContactUsModel{
  String name;
  String email;
  String phone;
  String subject;
  String message;

  ContactUsModel({
    this.phone,
    this.name,
    this.email,
    this.message,
    this.subject
});

  ContactUsModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    message = json['message'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['message'] = this.message;
    data['subject'] = this.subject;
    return data;
  }
}

