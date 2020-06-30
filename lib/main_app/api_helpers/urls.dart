//dev server
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';

const String kBaseUrDev = "http://dev.ishraak.com";
const String kBaseUrlQA = "http://dev.ishraak.com";
const String kBaseUrlProd = "http://100.25.85.115";

class Urls {
  /// new
  /// Those url should not contain base url
  /// base url will added by [ApiClient] before sending request

  static String signInUrl = "/api/company/signin/";
  static String passwordResetUrl = "api/company/forgot-password/";
  static String dashboardUrl = "/api/app-dashboard";
  static String passwordChangeUrl = "/api/pro/change-password/";
  static String postJobUrl = "/api/company/post-job/"; //<str:name>/
  static String openJobsCompany = "/api/job/search/?company="; //cname
  static String manageCandidateList = "/api/application/list"; //cname
  static String infoBoxUrl = "/api/company/dashboard/infobox/"; //cname
  static String dashboardChartUrl = "/api/company/dashboard/chart/"; //cname
  static String dashboardRecentActivityUrl = "/api/company/dashboard/recent_activity/"; //cname
  static String professionalPublicProfileUrl = "/api/pro/public-profile/"; //pro_id
  static String companyProfileUpdateUrl = "/api/company/update"; //id


  static String countryListUrl = "/api/country/list/";
  static String industryListUrl = "/api/industry/";
  static String companyListUrl = "/api/company/";
  static String genderListUrl = "/api/gender/list";
  static String nationalityListUrl = "/api/professional/nationality/";
  static String religionListUrl = "/api/professional/religion/";
  static String skillListUrl = "/api/skill/list/";
  static String instituteListUrl = "/api/professional/institute/";
  static String organizationListUrl = "/api/professional/organization/";
  static String majorListUrl = "/api/professional/major/";
  static String certificateNameListUrl = "/api/professional/certificate_name/";
  static String qualificationListUrl = "/api/qualification/list";
  static String experienceListUrl = "/api/experience/";
  static String jobCategoriesListUrl = "/api/job-category/list/";
  static String jobTypeListUrl = "/api/job-type/list";
  static String jobLocationListUrl = "/api/location/";
  static String jobSourceList = "/api/job-source/list/";
  static String jobGenderList = "/api/job-gender/list/";
  static String jobSiteList = "/api/job-site/list";
  static String jobNatureList = "/api/job-nature/list";
  static String jobDetailsUrl = "/api/job/get/";
  static String favouriteJobAddUrl = "/api/job/favourite/toggle";
  static String companySearchUrl = "/api/company/search";

  static String jwtRefreshUrl = "/api/token/refresh/";

//contact us
  static String settingsUrl = "/api/settings/";
  static String contactUsSubmitUrl = "/api/send_email_to_admin_contact_us/";

// webUrl
  static String aboutUsWeb = "/about-us-app/";
  static String contactUsWeb = "/contact-us-app/";
  static String careerAdviceWeb = "/career-advice-app/";
  static String faqWeb = "/FAQ-app/";
}
