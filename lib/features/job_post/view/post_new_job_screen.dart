import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/job_post/view_model/job_post_veiw_model.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_model.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/validator.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_date_picker_form_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:provider/provider.dart';

class PostNewJobScreen extends StatefulWidget {
  final JobModel jobModel;
  final JobPostViewModel jobPostViewModel = JobPostViewModel();

  PostNewJobScreen({this.jobModel});

  @override
  _PostNewJobScreenState createState() => _PostNewJobScreenState();
}

class _PostNewJobScreenState extends State<PostNewJobScreen> {
  bool isEditMode;
FocusNode _focusNode =  FocusNode();
  DateTime applicationDeadline;
  var _formKey = GlobalKey<FormState>();
  var _jobTitleTextEditingController = TextEditingController();
  var _jobVacancyTextEditingController = TextEditingController();
  var _jobAddressTextEditingController = TextEditingController();
  var _companyProfileTextEditingController = TextEditingController();
  var _jobAreaTextEditingController = TextEditingController();
  var _salaryTextEditingController = TextEditingController();
  var _salaryMinTextEditingController = TextEditingController();
  var _salaryMaxTextEditingController = TextEditingController();
  var _experienceTextEditingController = TextEditingController();
  var _jobCityTextEditingController = TextEditingController();


  String selectedGender;
  String selectedJobCategory;

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
    _experienceTextEditingController.text = job?.experience;
    selectedGender = job?.gender;
    selectedJobCategory = job?.jobCategory;
  }

  var spaceBetweenFields = SizedBox(
    height: 10,
  );

  _handlePost() {
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
        "experience": _experienceTextEditingController.text,
        "job_city": _jobCityTextEditingController.text,
      };

      var _vm = widget.jobPostViewModel;

      if (isEditMode) {
        // TODO: update existing post

      } else {
        // add new post
        _vm.postNewJob(data).then((value) {
          if (value) {
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
        var appBarText = isEditMode
            ? widget?.jobModel?.title ?? ""
            : StringResources.postNewJobText;
        return Scaffold(
          appBar: AppBar(
            title: Text(appBarText),
            actions: [
              EditScreenSaveButton(
                onPressed: _handlePost,
                text: isEditMode?"Update": "Post",
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
                  //salary
                  CustomTextFormField(
                    controller: _salaryTextEditingController,
                    labelText: StringResources.salary,
                  ),
                  spaceBetweenFields,

                  //vacancy
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
                      SizedBox(width: 10,),
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
                  CustomDropdownSearchFormField(
                    labelText: StringResources.genderText,
                    hintText: StringResources.tapToSelectText,
                    showSelectedItem: true,
                    items: _vm.genderList,
                    selectedItem: selectedGender,
                  ),
                  // job category
                  spaceBetweenFields,
                  CustomDropdownSearchFormField(
                    selectedItem: selectedJobCategory,
                    labelText: StringResources.category,
                    hintText: StringResources.tapToSelectText,
                    showSelectedItem: true,
                    onChanged: (v){

                    },
                    items: _vm.jobCategoryList,
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
                  SizedBox(height: 100,)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
