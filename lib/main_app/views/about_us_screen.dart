import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({Key key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  var url = "${FlavorConfig?.instance?.values?.baseUrl}${Urls.aboutUsWeb}";

  var htmlString = """
  

                  <div>
              
                        <h3>Our Mission</h3>
                
                        <p>
                            To provide an intelligent people-position matchmaking platform for the professionals and organizations.
                        </p>
                        <h3>Our Vision</h3>
                        <p>To create the most compelling job platform by ensuring the best job for every professional and ideal talent pool for every organization.</p>
                        <h3>Our Values</h3>
                        <p>
                            <b>Innovation and Proactiveness</b>: We actively pursue new and divergent ways to further our cause. Our tracks are built with utmost professionalism and creativity. We continuously adopt new cutting-edge technology concepts to best serve our professionals clients.
                        </p>
                        <p>
                            <b>Openness</b>: We value transparency and believe in sharing information so that we can constantly learn, collaborate and arrive at the right decisions.
                        </p>
                        <p>
                            <b>People Orientation</b>: We work together with integrity. We have respect and compassion for one another; fairness and group cohesion are strongly promoted.
                        </p>
                        <h3>About JobXprss</h3>
                        <p>JobXprss is the most advanced job platform in Bangladesh.</p>
                        <p>We use intelligent technology to match the right people with thousands of latest job postings obtained from numerous job sources.
                            Compiled resumes are also awaiting to be sorted as per client requirements.</p>
                      <p>Unlike other job sites, all these information are shared and presented in a way that best serves the
                          purpose of the professionals and the organizations. In turn, job seekers on JobXprss are more informed
                          about the jobs and the organizations they apply to and consider joining. JobXprss is available anywhere
                          through its mobile apps.</p>
                        <p>JobXprss is powered by Ishraak Solutions, a team of great technology experts.</p>
                    </div>
           
             
  
   """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.aboutUsText),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
              htmlString,
              textStyle: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
