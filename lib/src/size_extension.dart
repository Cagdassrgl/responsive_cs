import 'package:responsive_cs/responsive_cs.dart';

extension ResponsiveExtension on num {
  double get w => ResponsiveSizer.instance.wp(toDouble());
  double get h => ResponsiveSizer.instance.hp(toDouble());
  double get sp => ResponsiveSizer.instance.sp(toDouble());
}
