import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: slideImageOne,
    title: 'First page title text',
    description: 'First page description page...',
  ),
  Slide(
    imageUrl: slideImageTwo,
    title: 'Second page title text',
    description: 'Second page description page...',
  ),
  Slide(
    imageUrl: slideImageThree,
    title: 'Third page title text',
    description: 'Third page description page...',
  ),
];