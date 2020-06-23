import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:jobxprss_company/features/dashboard/models/skill_job_chart_data_model.dart';
import 'package:jobxprss_company/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class JobChartWidget extends StatelessWidget {
  final bool animate;
  final chLength = 90;

  JobChartWidget({this.animate = false});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var chartHeight = screenHeight / 2.2;
    var primaryColor = Theme.of(context).primaryColor;

//    var dummyDataList = [
//      SkillJobChartDataModel(month: "July", total: 40),
//      SkillJobChartDataModel(month: "August", total: 400),
//      SkillJobChartDataModel(month: "September", total: 300),
//      SkillJobChartDataModel(month: "October", total: 100),
//      SkillJobChartDataModel(month: "November", total: 80),
//      SkillJobChartDataModel(month: "December", total: 60),
//    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 5.0),
//            child: Consumer<UserProfileViewModel>(
//              builder:
//                  (BuildContext context, userProfileViewModel, Widget child) {
//                var dashboardViewModel =
//                    Provider.of<DashboardViewModel>(context);
//
//                if (userProfileViewModel.shouldShowLoader) {
//                  return SizedBox();
////                return Container(
////                  height: 200,
////                  child: Padding(
////                    padding: const EdgeInsets.all(8.0),
////                    child: Container(
////                        child: Shimmer.fromColors(
////                            baseColor: Colors.grey[300],
////                            highlightColor: Colors.grey[100],
////                            enabled: true,
////                            child: Column(
////                              children: [
////                                ProfessionalSkillListItem(
////                                  skillInfo: SkillInfo(
////                                      rating: 0,
////                                      skill: Skill(name: ""),
////                                      verifiedBySkillCheck: false),
////                                ),
////                              ],
////                            ))),
////                  ),
////                );
//                }
//
//                bool isExpanded = dashboardViewModel.idExpandedSkillList;
//                List<SkillInfo> skillList =
//                    userProfileViewModel?.userData?.skillInfo ?? [];
//
//                String skillText = _buildStringFromSkillList(skillList);
//
//                bool hasMoreText = skillText.length > chLength;
//                String skillsString = (isExpanded || !hasMoreText)
//                    ? skillText ?? ""
//                    : "${skillText?.substring(0, chLength)} ...." ?? "";
//
//                if(userProfileViewModel.appError !=  null){
//                  return SizedBox();
//                }
//
//                if (skillList.length == 0) {
//                  return Padding(
//                    padding: const EdgeInsets.all(4.0),
//                    child: RawMaterialButton(
//                      fillColor: Theme.of(context).backgroundColor,
//                      elevation: 3,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5)),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                            StringResources.addSkillText,
//                            style: TextStyle(color: primaryColor),
//                          ),
//                          Icon(
//                            Icons.add,
//                            color: primaryColor,
//                          )
//                        ],
//                      ),
//                      onPressed: () {
//                        Navigator.of(context).push(CupertinoPageRoute(
//                            builder: (context) => AddEditProfessionalSkill(
//                                  previouslyAddedSkills: skillList,
//                                )));
//                      },
//                    ),
//                  );
//                }
//                return Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: [
//                      Text(StringResources.monthlyJobsText,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
//                     SizedBox(height: 2,),
//                      Text("for Skills ($skillsString)",textAlign: TextAlign.center,),
//                      if (hasMoreText)
//                        Padding(
//                          padding: const EdgeInsets.only(top: 5),
//                          child: InkWell(
//                            onTap: () {
//                              dashboardViewModel.idExpandedSkillList =
//                                  !isExpanded;
//                            },
//                            child: Padding(
//                              padding: const EdgeInsets.all(3.0),
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: [
//                                  Text(
//                                    isExpanded
//                                        ? StringResources.seeLessText
//                                        : StringResources.seeMoreText,
//                                    style: TextStyle(
//                                        color: Theme.of(context).primaryColor),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                    ],
//                  ),
//                );
//              },
//            ),
//          ),
          Consumer<DashboardViewModel>(builder:
              (BuildContext context, dashboardViewModel, Widget child) {
            if (dashboardViewModel.shouldShowJoChartLoader) {
              return Container(
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.blue,
                          height: 200,
                          width: double.infinity,
                        ),
                      )));
            }

            List<SkillJobChartDataModel> list = [];
            if (dashboardViewModel.skillJobChartData.length >= 6)
              list = dashboardViewModel.skillJobChartData.sublist(0, 6);
            else
              list = dashboardViewModel.skillJobChartData;

            var seriesList = [
              charts.Series<SkillJobChartDataModel, String>(
                id: "Job Chart",
                domainFn: (v, _) => v.month ?? "Month",
                measureFn: (v, _) => v.total ?? 0,
                data: list.reversed.toList(),
                labelAccessorFn: (v, _) => '${v.total ?? ""}',
              )
            ];

            return Container(
              padding: EdgeInsets.all(8),
              height: chartHeight,
              child: charts.BarChart(
                seriesList,
                barGroupingType: charts.BarGroupingType.grouped,
//                vertical: false,
                animate: animate,
//        flipVerticalAxis: true,
                barRendererDecorator: new charts.BarLabelDecorator<String>(),

                behaviors: [
//              new charts.ChartTitle('Jobs Per Month',
//                  behaviorPosition: charts.BehaviorPosition.bottom,
//                  titleOutsideJustification:
//                      charts.OutsideJustification.middleDrawArea),
                ],
                primaryMeasureAxis: new charts.NumericAxisSpec(
                    tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                        desiredTickCount: 10)),
                secondaryMeasureAxis: new charts.NumericAxisSpec(
                    tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                        desiredTickCount: 3)),
              ),
            );
          }),
        ],
      ),
    );
  }

//  String _buildStringFromSkillList(List<SkillInfo> list) {
//    var skillList = list.map((e) => e?.skill?.name);
//    return skillList.join(", ");
//  }
}
