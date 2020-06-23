import 'package:intl/intl.dart';

class SkillJobChartDataModel {
  String month;
  int total;
  int year;
  DateTime dateTimeValue;

  Map<int, String> _monthsInYear = {
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "Jun",
    7: "Jul",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec"
  };

  Map<int, String> _monthsInYearF = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };

  SkillJobChartDataModel({
    this.month,
    this.total,
    this.year,
    this.dateTimeValue,
  });

  SkillJobChartDataModel.fromJson(json) {
    try {
      month = "${_monthsInYear[json[1]??""]}, ${json[0].toString().substring(2)}";
      total = json[2];
      year = json[0];
      dateTimeValue = DateTime.parse(
          '${json[0]}-${json[1]?.toString()?.padLeft(2, '0')}-01');
    } catch (e) {
      print(e);
    }

    ;
  }
}
