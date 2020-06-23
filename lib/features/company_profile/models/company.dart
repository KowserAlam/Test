import 'package:equatable/equatable.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

// ignore: must_be_immutable
class Company extends Equatable {
  String name;
  String email;
  String companyNameBdjobs;
  String companyNameFacebook;
  String companyNameGoogle;
  String basisMemberShipNo;
  DateTime yearOfEstablishment;
  String address;
  String postCode;
  String companyContactNoOne;
  String companyContactNoTwo;
  String companyContactNoThree;
  String webAddress;
  String organizationHead;
  String organizationHeadDesignation;
  String organizationHeadNumber;
  String legalStructure;
  String noOfHumanResources;
  String noOfResources;
  String contactPerson;
  String contactPersonDesignation;
  String contactPersonMobileNo;
  String contactPersonEmail;
  String companyProfile;
  String profilePicture;
  double latitude;
  double longitude;
  String createdDate;
  String division;
  String district;
  String user;
  String slug;
  String noOfItResources;
  String totalNumberOfHumanResources;
  String legalStructureOfThisCompany;
  String basisMembershipNo;
  String area;
  String city;
  String country;

  Company({
    this.name,
    this.email,
    this.companyNameBdjobs,
    this.companyNameFacebook,
    this.companyNameGoogle,
    this.basisMemberShipNo,
    this.yearOfEstablishment,
    this.address,
    this.postCode,
    this.companyContactNoOne,
    this.companyContactNoTwo,
    this.companyContactNoThree,
    this.webAddress,
    this.organizationHead,
    this.organizationHeadDesignation,
    this.organizationHeadNumber,
    this.legalStructure,
    this.noOfHumanResources,
    this.noOfResources,
    this.contactPerson,
    this.contactPersonDesignation,
    this.contactPersonMobileNo,
    this.contactPersonEmail,
    this.companyProfile,
    this.profilePicture,
    this.latitude,
    this.longitude,
    this.createdDate,
    this.division,
    this.district,
    this.user,
    this.slug,
    this.noOfItResources,
    this.totalNumberOfHumanResources,
    this.legalStructureOfThisCompany,
    this.basisMembershipNo,
    this.area,
    this.city,
    this.country,
  });

  Company.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    name = json['name']?.toString();
    email = json['email']?.toString();
    companyNameBdjobs = json['company_name_bdjobs']?.toString();
    companyNameFacebook = json['company_name_facebook']?.toString();
    companyNameGoogle = json['company_name_google']?.toString();
    basisMemberShipNo = json['basis_membership_no']?.toString();
    if (json['year_of_eastablishment'] != null) {
      yearOfEstablishment = DateTime.parse(json['year_of_eastablishment']);
    }
    address = json['address']?.toString();
    postCode = json['post_code']?.toString();
    companyContactNoOne = json['company_contact_no_one']?.toString();
    companyContactNoTwo = json['company_contact_no_two']?.toString();
    companyContactNoThree = json['company_contact_no_three']?.toString();
    webAddress = json['web_address']?.toString();
    organizationHead = json['organization_head']?.toString();
    organizationHeadDesignation =
        json['organization_head_designation']?.toString();
    organizationHeadNumber = json['organization_head_number']?.toString();
    legalStructure = json['legal_structure_of_this_company']?.toString();
    noOfHumanResources = json['total_number_of_human_resources']?.toString();
    noOfResources = json['no_of_it_resources']?.toString();
    contactPerson = json['contact_person']?.toString();
    contactPersonDesignation = json['contact_person_designation']?.toString();
    contactPersonMobileNo = json['contact_person_mobile_no']?.toString();
    contactPersonEmail = json['contact_person_email']?.toString();
    companyProfile = json['features.company_profile']?.toString();
    if (json['profile_picture'] != null) {
      profilePicture = "$baseUrl${json['profile_picture']}";
    }

    try {
      if (json['latitude'] != null)
        latitude = double.parse(json['latitude'].toString());
      if (json['longitude'] != null)
        longitude = double.parse(json['longitude'].toString());
    } catch (e) {
      print(e);
    }

    createdDate = json['created_date']?.toString();
    division = json['division']?.toString();
    district = json['district']?.toString();
    user = json['user']?.toString();
    slug = json['slug']?.toString();
    noOfItResources = json['no_of_it_resources']?.toString();
    noOfItResources = json['no_of_it_resources']?.toString();
    totalNumberOfHumanResources = json['total_number_of_human_resources']?.toString();
    legalStructureOfThisCompany = json['legal_structure_of_this_company']?.toString();
    basisMembershipNo = json['basis_membership_no']?.toString();
    area = json['area']?.toString();
    city = json['city']?.toString();
    country = json['country']?.toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['address'] = this.address;
    data['area'] = this.area;
    data['city'] = this.city;
    data['country'] = this.country;
    data['company_name_bdjobs'] = this.companyNameBdjobs;
    data['company_name_facebook'] = this.companyNameFacebook;
    data['company_name_google'] = this.companyNameGoogle;
    data['basis_membership_no'] = this.basisMembershipNo;
    data['year_of_eastablishment'] = this.yearOfEstablishment.toIso8601String();
    data['company_profile'] = this.companyProfile;
    data['company_contact_no_one'] = this.companyContactNoOne;
    data['company_contact_no_two'] = this.companyContactNoTwo;
    data['company_contact_no_three'] = this.companyContactNoThree;
    data['email'] = this.email;
    data['web_address'] = this.webAddress;
    data['organization_head'] = this.organizationHead;
    data['organization_head_designation'] = this.organizationHeadDesignation;
    data['organization_head_number'] = this.organizationHeadNumber;
    data['legal_structure_of_this_company'] = this.legalStructureOfThisCompany;
    data['total_number_of_human_resources'] = this.totalNumberOfHumanResources;
    data['no_of_it_resources'] = this.noOfItResources;
    data['contact_person'] = this.contactPerson;
    data['contact_person_designation'] = this.contactPersonDesignation;
    data['contact_person_mobile_no'] = this.contactPersonMobileNo;
    data['contact_person_email'] = this.contactPersonEmail;
    data['profile_picture'] = this.profilePicture;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['user'] = this.user;
    return data;
  }

  @override
  String toString() {
    return name;
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        name,
        email,
        address,
        companyContactNoOne,
        contactPerson,
        contactPersonDesignation,
        contactPersonMobileNo,
        contactPersonEmail,
        profilePicture,
        createdDate,
      ];
}
