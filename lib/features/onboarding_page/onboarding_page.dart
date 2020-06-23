import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/onboarding_page/slide.dart';
import 'package:jobxprss_company/features/onboarding_page/slide_dots.dart';
import 'package:jobxprss_company/features/onboarding_page/slide_item.dart';
import 'package:jobxprss_company/main_app/home.dart';
import 'package:jobxprss_company/main_app/util/local_storage.dart';


class OnboardingScreens extends StatefulWidget {
  @override
  _OnboardingScreensState createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1200), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: slideList.length,
                itemBuilder: (ctx, i) => SlideItem(i),
              ),
              Positioned(
                bottom: 80,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for(int i = 0; i<slideList.length; i++)
                      if( i == _currentPage )
                        SlideDots(true)
                      else
                        SlideDots(false)
                  ],
                ),
              ),
              _currentPage == 0?SizedBox():Positioned(
                bottom: 5,
                left: 5,
                child: GestureDetector(
                    onTap: (){
                      _pageController.animateToPage(
                        _currentPage-1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Icon(Icons.keyboard_arrow_left, color: Colors.blue,size: 30,)),
              ),
              _currentPage == 2?SizedBox():Positioned(
                bottom: 5,
                right: 5,
                child: GestureDetector(
                    onTap: (){
                      _pageController.animateToPage(
                        _currentPage+1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Icon(Icons.keyboard_arrow_right, color: Colors.blue,size: 30,)),
              ),
              _currentPage == 2?
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    _setIntoDone();
                    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
                        builder: (context) => Home()),(_)=>false);
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text('Continue', style: TextStyle(color: Colors.blueAccent),),
                    ),
                  ),
                ),
              ):
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                      onTap: () {
                        _setIntoDone();
                        Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
                            builder: (context) => Home()),(_)=>false);
                      },
                      child: Text('Skip', style: TextStyle(color: Colors.blue,fontSize: 16),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _setIntoDone()async{
    var _storage = await LocalStorageService.getInstance();
    var val = _storage.saveBool("showIntro",false);
  }

}