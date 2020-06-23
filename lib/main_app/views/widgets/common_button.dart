import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final double circularRadius;

  /// width could be null
  /// default width 135 for large device and 115 for mobile device
  final double width;
  final double height;

  const CommonButton({
    @required this.label,
    @required this.onTap,
    this.width = 115,
    this.height = 60,
    this.circularRadius = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(circularRadius),
      color: Colors.transparent,
      elevation: onTap == null ? 0 : 5.0,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: onTap == null ? Colors.grey : null,
            borderRadius: BorderRadius.circular(circularRadius),
            gradient: onTap == null ? null : AppTheme.defaultLinearGradient),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(circularRadius),
            onTap: onTap,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
