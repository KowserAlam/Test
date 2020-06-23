import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/onboarding_page/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              child: CircleAvatar(
                maxRadius: 54.0,
                backgroundImage:
                AssetImage(slideList[index].imageUrl),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1
                    )
                  ]
              ),
            ),
            //image: AssetImage(slideList[index].imageUrl),
            SizedBox(
              height: 40,
            ),
            Text(
              slideList[index].title,
              style: TextStyle(
                fontSize: 22,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              slideList[index].description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}