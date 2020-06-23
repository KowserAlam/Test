import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';


class BlueButton extends StatefulWidget {
  final double height;
  final double width;
  final String text;
  final Function onPressed;
  BlueButton({@required this.height, this.width, this.text, this.onPressed});
  @override
  _BlueButtonState createState() => _BlueButtonState();
}

class _BlueButtonState extends State<BlueButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue,
        ),
        child: Center(
          child: Text(widget.text, style: TextStyle(fontSize: widget.height/4, fontWeight: FontWeight.bold, color: Colors.white),),
        ),
      ),
    );
  }
}

class GreyToWhiteButtonWithIcon extends StatefulWidget {
  final double height;
  final double width;
  final String text;
  final IconData iconData;
  final Function onPressed;
  GreyToWhiteButtonWithIcon({@required this.height, this.width, this.text, this.onPressed, this.iconData});
  @override
  _GreyToWhiteButtonWithIconState createState() => _GreyToWhiteButtonWithIconState();
}

class _GreyToWhiteButtonWithIconState extends State<GreyToWhiteButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: (){
        widget.onPressed;
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: isDarkMode?AppTheme.darkLinearGradient:AppTheme.lightLinearGradient,
          border: Border.all(width: 1, color: Colors.grey[300])
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(widget.iconData, size: widget.height/4),
            SizedBox(width: 5,),
            Text(widget.text, style: TextStyle(fontSize: widget.height/4, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
