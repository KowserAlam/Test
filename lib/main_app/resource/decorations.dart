import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';

var grad = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Colors.grey[100], Colors.white]
);

BoxDecoration greyToWhiteDecoration = new BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  gradient: LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Colors.grey[100], Colors.white]
  ),
  border: Border.all(color: Colors.grey[200], width: 1)
);

BoxDecoration nMbox = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: AppTheme.mC,
    boxShadow: [
      BoxShadow(
          color: AppTheme.mCD,
          offset: Offset(10,10),
          blurRadius: 10
      ),
      BoxShadow(
          color: AppTheme.mCL,
          offset: Offset(-10,-10),
          blurRadius: 10
      )
    ]
);

BoxDecoration nMboxGrad = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: AppTheme.mC,
    gradient: LinearGradient(
        colors: [AppTheme.shadowColor, AppTheme.lightShadowColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
    ),
    boxShadow: [
      BoxShadow(
          color: AppTheme.mCD,
          offset: Offset(10,10),
          blurRadius: 10
      ),
      BoxShadow(
          color: AppTheme.mCL,
          offset: Offset(-10,-10),
          blurRadius: 10
      )
    ]
);

BoxDecoration nMboxInvert = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: AppTheme.mCD,
    boxShadow: [
      BoxShadow(
          color: AppTheme.mCL,
          offset: Offset(3,3),
          blurRadius: 3,
          spreadRadius: -3
      ),
    ]
);

BoxDecoration nMboxInvertActive = nMboxInvert.copyWith(color: AppTheme.mCC);