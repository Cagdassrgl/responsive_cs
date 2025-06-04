import 'package:flutter/material.dart' hide Orientation;
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_cs/responsive_cs.dart';

void main() {
  group('ResponsiveSizer Tests', () {
    late Widget testWidget;
    const testDesignSize = Size(375, 812); // iPhone 13 design size

    setUp(() {
      testWidget = MaterialApp(
        home: Builder(
          builder: (context) {
            ResponsiveSizer.init(context: context, designSize: testDesignSize);
            return Container();
          },
        ),
      );
    });

    testWidgets('Initialization test', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(ResponsiveSizer.instance, isNotNull);
    });

    testWidgets('Device type detection - mobile portrait', (tester) async {
      // 360x640 (Mobile portrait)

      tester.binding.window.physicalSizeTestValue = const Size(360, 640);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(testWidget);

      expect(ResponsiveSizer.instance.deviceType, DeviceType.mobile);
      expect(ResponsiveSizer.instance.orientation, Orientation.portrait);
    });

    testWidgets('Device type detection - tablet landscape', (tester) async {
      // 1024x768 - (iPad)
      tester.binding.window.physicalSizeTestValue = const Size(1024, 768);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(testWidget);

      expect(ResponsiveSizer.instance.deviceType, DeviceType.tablet);
      expect(ResponsiveSizer.instance.orientation, Orientation.landscape);
    });

    testWidgets('Device type detection - desktop', (tester) async {
      // 1920x1080 - (Desktop)
      tester.binding.window.physicalSizeTestValue = const Size(1920, 1080);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(testWidget);

      expect(ResponsiveSizer.instance.deviceType, DeviceType.desktop);
    });

    testWidgets('Size calculations - portrait mode', (tester) async {
      // 360x640 (Mobile portrait)
      tester.binding.window.physicalSizeTestValue = const Size(360, 640);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(testWidget);

      final responsive = ResponsiveSizer.instance;

      // Design Size: 375x812
      // Device Size: 360x640
      // scaleWidth = 360/375 = 0.96
      // scaleHeight = 640/812 ≈ 0.788
      // scaleText = min(0.96, 0.788) = 0.788

      expect(responsive.scaleWidth, closeTo(0.96, 0.001));
      expect(responsive.scaleHeight, closeTo(0.788, 0.001));
      expect(responsive.scaleText, closeTo(0.788, 0.001));

      // 100 width units in design = 96 in actual
      expect(responsive.wp(100), closeTo(96, 0.1));
      // 100 height units in design ≈ 78.8 in actual
      expect(responsive.hp(100), closeTo(78.8, 0.1));
      // 16 text size in design ≈ 12.61 in actual
      expect(responsive.sp(16), closeTo(12.61, 0.1));
    });

    testWidgets('Size calculations - landscape mode', (tester) async {
      // 640x360 (Mobile landscape)
      tester.binding.window.physicalSizeTestValue = const Size(640, 360);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(testWidget);

      final responsive = ResponsiveSizer.instance;

      expect(responsive.orientation, Orientation.landscape);

      // Design Size: 375x812 (portrait)
      // Device Size: 640x360 (landscape)
      // scaleWidth = 640/375 ≈ 1.706
      // scaleHeight = 360/812 ≈ 0.443
      // scaleText = min(1.706, 0.443) = 0.443

      expect(responsive.scaleWidth, closeTo(1.706, 0.001));
      expect(responsive.scaleHeight, closeTo(0.443, 0.001));
      expect(responsive.scaleText, closeTo(0.443, 0.001));
    });

    testWidgets('Extension methods test', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(360, 640);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(testWidget);

      // 100.w should be same as wp(100)
      expect(100.w, ResponsiveSizer.instance.wp(100));
      // 50.h should be same as hp(50)
      expect(50.h, ResponsiveSizer.instance.hp(50));
      // 16.sp should be same as sp(16)
      expect(16.sp, ResponsiveSizer.instance.sp(16));
    });
  });
}
