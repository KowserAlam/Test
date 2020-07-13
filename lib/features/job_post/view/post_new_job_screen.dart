import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:jobxprss_company/features/job_post/view_model/job_post_veiw_model.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/custom_text_from_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:provider/provider.dart';

class PostNewJobScreen extends StatefulWidget {
  final JobPostViewModel jobPostViewModel = JobPostViewModel();
  @override
  _PostNewJobScreenState createState() => _PostNewJobScreenState();
}

class _PostNewJobScreenState extends State<PostNewJobScreen> {

 var _jobTitleTextEditingController = TextEditingController();
 var _jobVacancyTextEditingController = TextEditingController();
 var _jobAddressTextEditingController = TextEditingController();

 var spaceBetweenFields = SizedBox(height: 10,);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>widget.jobPostViewModel,
      child: Consumer<JobPostViewModel>(
        builder: (context, snapshot,_) {
          return Scaffold(
            appBar: AppBar(
              title: Text(StringResources.postNewJobText),
              actions: [
                EditScreenSaveButton(onPressed:(){

                }, text: "Post",),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Form(
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _jobTitleTextEditingController,
                      labelText: StringResources.jobTitleText,
                      hintText: StringResources.jobTitleText,
                    ),
                    spaceBetweenFields,
                    CustomTextFormField(
                      controller: _jobAddressTextEditingController,
                      labelText: StringResources.jobLocation,
                      hintText: StringResources.addressText,
                    ),
                    spaceBetweenFields,
                    CustomTextFormField(
                      controller: _jobVacancyTextEditingController,
                      labelText: StringResources.vacancy,
                      hintText: StringResources.vacancyHintText,
                    ),
                    spaceBetweenFields,
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
