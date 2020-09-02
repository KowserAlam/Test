//dev server
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';

const String kBaseUrDev = "http://dev.ishraak.com";
const String kBaseUrlQA = "http://dev.ishraak.com";
const String kBaseUrlProd = "https://jobxprss.com";

class Urls {
  /// new
  /// Those url should not contain base url
  /// base url will added by [ApiClient] before sending request

  static String signInUrl = "/api/company/signin/";
  static String passwordResetUrl = "api/company/forgot-password/";
  static String dashboardUrl = "/api/app-dashboard";
  static String passwordChangeUrl = "/api/pro/change-password/";
  static String postNewJobUrl = "/api/job/create/";
  static String updateJobUrl = "/api/job/update/"; // job id
  static String jobMakeUnpublishUrl = "/api/job/update/unpublish/"; // job id
  static String jobMakeUnPublishUrl = "/api/job/update/publish/"; // job id

  static String openJobsCompany = "/api/company/job/search/"; //cname
  static String manageCandidateList = "/api/application/list"; //cname
  static String infoBoxUrl = "/api/company/dashboard/infobox/"; //cname
  static String dashboardChartUrl = "/api/company/dashboard/chart/"; //cname
  static String dashboardRecentActivityUrl = "/api/company/dashboard/recent_activity/"; //cname
  static String professionalPublicProfileUrl = "/api/pro/public-profile/"; //pro_id
  static String companyProfileUpdateUrl = "/api/company/update"; //id
  static String profileCompleteness = "/api/pro/profile-completeness/";


  static String cityListUrl = "/api/city/list/";
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
  static String jobExperienceList = "/api/experience/list";
  static String jobNatureList = "/api/job-nature/list";
  static String jobDetailsUrl = "/api/company/job/get/";
  static String favouriteJobAddUrl = "/api/job/favourite/toggle";
  static String companySearchUrl = "/api/company/search";
  static String jwtRefreshUrl = "/api/token/refresh/";

  static String createMessageListUrl = "/api/employer-message-create/";
  static String messageSenderListUrl = "/api/sender-list/";
  static String senderMessageListUrl = "/api/sender-message-list/?sender="; //  id 75

//contact us
  static String settingsUrl = "/api/settings/";
  static String contactUsSubmitUrl = "/api/send_email_to_admin_contact_us/";

// webUrl
  static String aboutUsWeb = "/about-us-app/";
  static String contactUsWeb = "/contact-us-app/";
  static String careerAdviceWeb = "/career-advice-app/";
  static String faqWeb = "/FAQ-app/";
}
