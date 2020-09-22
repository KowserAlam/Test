class ReferenceData {
  int referenceId;
  String description;

  ReferenceData({this.referenceId, this.description});

  ReferenceData.fromJson(Map<String, dynamic> json) {
    referenceId = json['id'];
    description = json['description']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    return data;
  }
}
