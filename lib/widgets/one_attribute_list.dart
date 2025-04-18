import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class OneAttributeList {
  final String imagePath;
  final String name;
  final String indicator;
  final String value;
  final String weight;
  late SvgPicture icon;
  late Color color;

  OneAttributeList({
    required this.imagePath,
    required this.name,
    required this.value,
    required this.indicator,
    required this.weight,
  }){
    if (indicator=='کالری'){
      icon=SvgPicture.asset(
        'assets/icons/fire 2.svg',
        width: 12,
        height: 12,
        color: Color(0xFF232A34),
      );
      color=Color(0xFF232A34);

    } else if (indicator=='قند'){
      icon=SvgPicture.asset(
        'assets/icons/sugar.svg',
        width: 12,
        height: 12,
        color: Color(0xFFF2506E),
      );
      color=Color(0xFFF2506E);
    }else if (indicator=='چربی'){
      icon=SvgPicture.asset(
        'assets/icons/bottle_2.svg',
        width: 12,
        height: 12,
        color: Color(0xFFF5AE32),
      );
      color=Color(0xFFF5AE32);
    }else if (indicator=='اسید چرب'){
      icon=SvgPicture.asset(
        'assets/icons/olives.svg',
        width: 12,
        height: 12,
        color: Color(0xFF8348F9),
      );
      color=Color(0xFF8348F9);
    }else{ //نمک
      icon=SvgPicture.asset(
        'assets/icons/salt.svg',
        width: 12,
        height: 12,
        color: Color(0xFF4BB4D7),
      );
      color=Color(0xFF4BB4D7);
    }
  }
}