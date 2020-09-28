
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardValues{
  static const double paddingBetweenSection = 16;
  static const double paddingBetweenSectionLabel = 8;
  static const Widget sizedBoxBetweenSection = SizedBox(height: paddingBetweenSection,);
  static const Widget sizedBoxBetweenSectionLabel = SizedBox(height: paddingBetweenSectionLabel,);
  static final dashboardSectionLabelStyle = TextStyle(
    fontFamily: GoogleFonts.oxygen().fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}