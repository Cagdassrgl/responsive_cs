import 'dart:math';
import 'package:flutter/widgets.dart' hide Orientation;
import 'package:responsive_cs/responsive_cs.dart';

class ResponsiveSizer {
  static ResponsiveSizer? _instance;

  final BuildContext context;
  final Size designSize;

  ResponsiveSizer._({required this.context, required this.designSize});

  factory ResponsiveSizer.init({required BuildContext context, required Size designSize}) {
    _instance = ResponsiveSizer._(context: context, designSize: designSize);
    return _instance!;
  }

  static ResponsiveSizer get instance {
    if (_instance == null) {
      throw Exception('ResponsiveSizer is not initialized. Call ResponsiveSizer.init() first');
    }
    return _instance!;
  }

  // Ekran boyutları
  Size get screenSize => MediaQuery.of(context).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  double get screenRatio => screenWidth / screenHeight;

  // Cihaz türü
  DeviceType get deviceType {
    final shortestSide = screenSize.shortestSide;
    if (shortestSide < 600) return DeviceType.mobile;
    if (shortestSide < 900) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  // Yönlendirme
  Orientation get orientation {
    return screenWidth > screenHeight ? Orientation.landscape : Orientation.portrait;
  }

  // Yatay ve dikey mod için ölçeklendirilmiş boyutlar
  double get scaleWidth => screenWidth / designSize.width;
  double get scaleHeight => screenHeight / designSize.height;
  double get scaleText => min(scaleWidth, scaleHeight);

  // Dinamik boyutlandırma
  double wp(double width) => width * scaleWidth;
  double hp(double height) => height * scaleHeight;
  double sp(double fontSize) => fontSize * scaleText;
}
