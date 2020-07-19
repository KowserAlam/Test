import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/job_post/view_model/job_post_veiw_model.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_model.dart';
import 'package:jobxprss_company/main_app/repositories/job_nature_list_repository.dart';
import 'package:jobxprss_company/main_app/repositories/job_site_list_repository.dart';
import 'package:jobxprss_company/main_app/repositories/job_type_list_repository.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/validator.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_date_picker_form_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_field_rich_html.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class PostNewJobScreen extends StatefulWidget {
  final JobModel jobModel;
  final JobPostViewModel jobPostViewModel = JobPostViewModel();
  final bool copyAsNew;

  PostNewJobScreen({this.jobModel,this.copyAsNew = false});

  @override
  _PostNewJobScreenState createState() => _PostNewJobScreenState();
}

class _PostNewJobScreenState extends State<PostNewJobScreen> {
  bool isEditMode;
  FocusNode _focusNode = FocusNode();
  DateTime applicationDeadline;
  var _formKey = GlobalKey<FormState>();

  String result = "";

  var _jobTitleTextEditingController = TextEditingController();
  var _jobVacancyTextEditingController = TextEditingController();
  var _jobAddressTextEditingController = TextEditingController();
  var _companyProfileTextEditingController = TextEditingController();
  var _jobAreaTextEditingController = TextEditingController();
  var _salaryTextEditingController = TextEditingController();
  var _salaryMinTextEditingController = TextEditingController();
  var _salaryMaxTextEditingController = TextEditingController();
  var _jobCityTextEditingController = TextEditingController();
  var _jobDescriptionTextValue = "";
  var _jobResponsibilitiesTextValue = "";
  var _jobEducationsTextValue = "";
  var _jobAdditionalRequirementsTextValue = "";
  var _jobOtherBenefitsTextValue = "";

  String selectedGender;
  String selectedJobCategory;
  String selectedJobQualification;
  String selectedJobExperience;
  JobSite selectedJobSite;
  JobType selectedJobType;
  JobNature selectedJobNature;

  @override
  void initState() {
    widget.jobPostViewModel.getData();
    isEditMode = widget.jobModel != null;
    if (isEditMode) _initTextFieldsValue();

    super.initState();
  }

  _initTextFieldsValue() {
    var job = widget.jobModel;
    applicationDeadline = job?.applicationDeadline;
    _jobTitleTextEditingController.text = job?.title;
    _jobVacancyTextEditingController.text = job?.vacancy?.toString();
    _jobAddressTextEditingController.text = job?.jobAddress;
    _companyProfileTextEditingController.text = job?.companyProfile;
    _salaryTextEditingController.text = job?.salary;
    _salaryMinTextEditingController.text = job?.salaryMin;
    _salaryMaxTextEditingController.text = job?.salaryMax;
    _jobAreaTextEditingController.text = job?.jobArea;
    _jobCityTextEditingController.text = job?.jobCity;
    selectedGender = job?.gender;
    selectedJobCategory = job?.jobCategory;
    selectedJobExperience = job?.experience;
    selectedJobQualification = job?.qualification;

    _jobDescriptionTextValue = job?.descriptions ?? "";
    _jobResponsibilitiesTextValue = job?.responsibilities ?? "";
    _jobAdditionalRequirementsTextValue = job?.additionalRequirements ?? "";
    _jobOtherBenefitsTextValue = job?.otherBenefits ?? "";
    _jobEducationsTextValue = job?.education ?? "";

    JobSiteListRepository().getIdToObj(job?.jobSite).then((value) {
      setState(() {
        selectedJobSite = value;
      });
    });

    JobNatureListRepository().getIdToObj(job?.jobNature).then((value) {
      setState(() {
        selectedJobNature = value;
      });
    });

    JobTypeListRepository().getIdToObj(job?.jobType).then((value) {
      setState(() {
        selectedJobType = value;
      });
    });
  }

  var spaceBetweenFields = SizedBox(
    height: 10,
  );

  _handlePost() async {
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      Map<String, dynamic> data = {
        "title": _jobTitleTextEditingController.text,
        "vacancy": _jobVacancyTextEditingController.text,
        "address": _jobAddressTextEditingController.text,
        "company_profile": _companyProfileTextEditingController.text,
        "salary": _salaryTextEditingController.text,
        "salary_min": _salaryMinTextEditingController.text,
        "salary_max": _salaryMaxTextEditingController.text,
        "job_area": _jobAreaTextEditingController.text,
        "experience": selectedJobExperience ?? "",
        "qualification": selectedJobQualification ?? "",
        "job_category": selectedJobCategory ?? "",
        "job_gender_id": selectedGender ?? "",
        "job_nature": selectedJobNature?.id ?? "",
        "job_type": selectedJobType?.id ?? "",
        "job_site": selectedJobType?.id ?? "",
        "job_city": _jobCityTextEditingController.text,
        "description": _jobDescriptionTextValue,
        "other_benefits": _jobOtherBenefitsTextValue,
        "additional_requirements": _jobAdditionalRequirementsTextValue,
        "education": _jobEducationsTextValue,
        "responsibilities": _jobResponsibilitiesTextValue,
      };

//      print(data);

      var _vm = widget.jobPostViewModel;

      if (isEditMode && !widget.copyAsNew) {
        // TODO: update existing post
        Logger().i(data);
        debugPrint("Update Job");

      } else {
        // add new post
        _vm.postNewJob(data).then((value) {
          if (value) {
            debugPrint("Post a new job");
            Navigator.pop(context);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => widget.jobPostViewModel,
      child: Consumer<JobPostViewModel>(builder: (context, _vm, _) {
        var appBarText = isEditMode && !widget.copyAsNew
            ? widget?.jobModel?.title ?? ""
            : StringResources.postNewJobText;
        return Scaffold(
          appBar: AppBar(
            title: Text(appBarText),
            actions: [
              EditScreenSaveButton(
                onPressed: _handlePost,
                text: isEditMode && !widget.copyAsNew ? "Update" : "Post",
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //title
                  CustomTextFormField(
                    required: true,
                    validator: Validator().nullFieldValidate,
                    controller: _jobTitleTextEditingController,
                    labelText: StringResources.jobTitleText,
                    hintText: StringResources.jobTitleText,
                  ),
                  spaceBetweenFields,
                  // job description
                  CustomTextFieldRichHtml(
                    labelText: StringResources.jobDescriptionTitle,
                    height: 400,
                    value: _jobDescriptionTextValue,
                    onDone: (v) {
                      _jobDescriptionTextValue = v;
                    },
                    customToolbar: """
                       [
                         ['style', ['bold', 'italic', 'underline', 'clear']],
                          ['para', ['ul', 'ol', 'paragraph']],
                          ['height', ['height']],
                       ]
                     """,
                  ),
                  spaceBetweenFields,

                  //address
                  CustomTextFormField(
                    required: true,
                    validator: Validator().nullFieldValidate,
                    controller: _jobAddressTextEditingController,
                    labelText: StringResources.jobLocation,
                    hintText: StringResources.addressText,
                    maxLines: 6,
                    minLines: 3,
                  ),
                  spaceBetweenFields,

// area
                  CustomTextFormField(
                    controller: _jobAreaTextEditingController,
                    labelText: StringResources.jobAreaText,
                    hintText: StringResources.jobAreaText,
                  ),
                  spaceBetweenFields,

// city
                  CustomTextFormField(
                    controller: _jobCityTextEditingController,
                    labelText: StringResources.jobCityText,
                    hintText: StringResources.jobCityHintText,
                  ),
                  spaceBetweenFields,

                  //vacancy
                  CustomTextFormField(
                    required: true,
                    validator: Validator().integerNumberValidator,
                    controller: _jobVacancyTextEditingController,
                    labelText: StringResources.vacancy,
                    hintText: StringResources.vacancyHintText,
                  ),
                  spaceBetweenFields,

                  // Responsibilities
                  CustomTextFieldRichHtml(
                    labelText: StringResources.responsibilitiesTitle,
                    value: _jobResponsibilitiesTextValue,
                    onDone: (v) {
                      _jobResponsibilitiesTextValue = v;
                    },
                  ),
                  spaceBetweenFields,

                  // Education
                  CustomTextFieldRichHtml(
                    labelText: StringResources.educationsText,
                    value: _jobEducationsTextValue,
                    onDone: (v) {
                      _jobEducationsTextValue = v;
                    },
                  ),
                  spaceBetweenFields,

                  // Additional Requirements
                  CustomTextFieldRichHtml(
                    labelText: StringResources.jobAdditionalRequirementsText,
                    value: _jobAdditionalRequirementsTextValue,
                    onDone: (v) {
                      _jobAdditionalRequirementsTextValue = v;
                    },
                  ),
                  spaceBetweenFields,
                  // otherBenefitsTitle
                  CustomTextFieldRichHtml(
                    labelText: StringResources.otherBenefitsTitle,
                    value: _jobOtherBenefitsTextValue,
                    onDone: (v) {
                      _jobOtherBenefitsTextValue = v;
                    },
                  ),
                  spaceBetweenFields,

                  //salary
                  CustomTextFormField(
                    controller: _salaryTextEditingController,
                    labelText: StringResources.salary,
                  ),
                  spaceBetweenFields,

                  //salary range
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          validator: Validator().moneyAmountNullableValidate,
                          controller: _salaryMinTextEditingController,
                          labelText: StringResources.salaryRangeText,
                          hintText: StringResources.salaryMin,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextFormField(
                          validator: Validator().moneyAmountNullableValidate,
                          controller: _salaryMaxTextEditingController,
                          hintText: StringResources.salaryMax,
                          labelText: "",
                        ),
                      ),
                    ],
                  ),
                  spaceBetweenFields,

                  // application deadline

                  CommonDatePickerFormField(
                    onDateTimeChanged: (DateTime d) {
                      applicationDeadline = d;
                      setState(() {});
                    },
                    date: applicationDeadline,
                    label: StringResources.applicationDeadline,
                  ),
// gender
                  spaceBetweenFields,
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdownSearchFormField(
                          labelText: StringResources.genderText,
                          hintText: StringResources.tapToSelectText,
                          showSelectedItem: true,
                          items: _vm.genderList,
                          selectedItem: selectedGender,
                          onChanged: (v) {
                            selectedGender = v;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // experience
                      Expanded(
                        child: CustomDropdownSearchFormField(
                          selectedItem: selectedJobExperience,
                          labelText: StringResources.experience,
                          hintText: StringResources.tapToSelectText,
                          showSelectedItem: true,
                          onChanged: (v) {
                            selectedJobExperience = v;
                          },
                          items: _vm.experienceList,
                        ),
                      ),
                    ],
                  ),
                  // job category
                  spaceBetweenFields,
                  CustomDropdownSearchFormField(
                    selectedItem: selectedJobCategory,
                    labelText: StringResources.category,
                    hintText: StringResources.tapToSelectText,
                    showSelectedItem: true,
                    onChanged: (v) {
                      selectedJobCategory = v;
                    },
                    items: _vm.jobCategoryList,
                  ),
                  spaceBetweenFields,

                  // qualification
                  CustomDropdownSearchFormField(
                    selectedItem: selectedJobQualification,
                    labelText: StringResources.qualificationText,
                    hintText: StringResources.tapToSelectText,
                    showSelectedItem: true,
                    onChanged: (v) {
                      selectedJobQualification = v;
                    },
                    items: _vm.qualifications,
                  ),
                  spaceBetweenFields,
                  // job site
                  CustomDropdownSearchFormField<JobSite>(
                    selectedItem: selectedJobSite,
                    labelText: StringResources.jobSiteText,
                    hintText: StringResources.tapToSelectText,
                    showSelectedItem: true,
                    itemAsString: (v) => v.text,
                    onChanged: (v) {
                      selectedJobSite = v;
                    },
                    items: _vm.jobSiteList,
                  ),
                  spaceBetweenFields,

                  //job type
                  CustomDropdownSearchFormField<JobNature>(
                    selectedItem: selectedJobNature,
                    labelText: StringResources.jobNature,
                    hintText: StringResources.tapToSelectText,
                    showSelectedItem: true,
                    itemAsString: (v) => v.text,
                    onChanged: (v) {
                      selectedJobNature = v;
                    },
                    items: _vm.jobNature,
                  ),
                  spaceBetweenFields,

                  //job nature
                  CustomDropdownSearchFormField<JobType>(
                    selectedItem: selectedJobType,
                    labelText: StringResources.jobSiteText,
                    hintText: StringResources.tapToSelectText,
                    showSelectedItem: true,
                    itemAsString: (v) => v.text,
                    onChanged: (v) {
                      selectedJobType = v;
                    },
                    items: _vm.jobType,
                  ),
                  spaceBetweenFields,

//profile
                  CustomTextFormField(
                    minLines: 3,
                    maxLines: 8,
                    controller: _companyProfileTextEditingController,
                    labelText: StringResources.jobAboutCompanyText,
                    hintText: StringResources.companyProfileText,
                  ),
                  spaceBetweenFields,
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
