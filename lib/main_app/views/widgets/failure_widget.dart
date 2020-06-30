import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FailureFullScreenWidget extends StatelessWidget {
  final String errorMessage;
  final Function onTap;

  const FailureFullScreenWidget({
    @required this.errorMessage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          (AppBar().preferredSize.height * 2),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FontAwesomeIcons.exclamationTriangle,
                  size: 40, color: Colors.grey),
              SizedBox(
                height: 15,
              ),
              Text(
                errorMessage ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .apply(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
