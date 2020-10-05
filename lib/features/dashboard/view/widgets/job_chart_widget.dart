import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';
import 'package:jobxprss_company/features/dashboard/models/skill_job_chart_data_model.dart';
import 'package:jobxprss_company/features/dashboard/values.dart';
import 'package:jobxprss_company/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
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
    var chartHeight = 300.0;
    var primaryColor = Theme.of(context).primaryColor;


    return Column(
      children: [
        Row(
          children: [
            Text(StringResources.jobsPostedMonthlyText,style: DashboardValues.dashboardSectionLabelStyle,),
          ],
        ),
        DashboardValues.sizedBoxBetweenSectionLabel,
        GetBuilder<DashboardViewModel>(builder:
            (DashboardViewModel dashboardViewModel,) {
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

          var seriesList2 = [
            charts.Series<SkillJobChartDataModel, DateTime>(
              id: "Job Chart2",
              domainFn: (v, _) => v.dateTimeValue,
              measureFn: (v, _) => v.total ?? 0,
              fillColorFn: (_, __) =>
                  charts.ColorUtil.fromDartColor(Colors.orange),
              colorFn: (_, __) =>
                  charts.ColorUtil.fromDartColor(AppTheme.colorPrimary),
              data: list.reversed.toList(),
            )
          ];

          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 14,bottom: 8),
                color: Theme.of(context).backgroundColor,
                height: chartHeight,
                child: charts.TimeSeriesChart(
                  seriesList2,
                  animate: animate,
                  defaultRenderer: new charts.LineRendererConfig(
                      includePoints: true, includeArea: true),
                  domainAxis: new charts.DateTimeAxisSpec(),
                  primaryMeasureAxis: new charts.NumericAxisSpec(
                    showAxisLine: true,
                    tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                        desiredTickCount: 5),
                  ),

                ),

              ),

            ],
          );

        }),
      ],
    );
  }

}
