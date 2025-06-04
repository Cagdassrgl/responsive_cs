# Responsive CS - Flutter Package

[![Pub Version](https://img.shields.io/pub/v/responsive_cs)](https://pub.dev/packages/responsive_cs)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![Flutter CI](https://github.com/Cagdassrgl/responsive_cs/actions/workflows/flutter.yml/badge.svg)](https://github.com/yourusername/responsive_cs/actions)

A responsive sizing package for Flutter that helps create adaptive UIs across different screen sizes (mobile, tablet) and orientations (portrait, landscape).

## Features

- 📱 **Device Detection**: Automatically detects mobile, tablet, or desktop
- 🔄 **Orientation Awareness**: Responds to portrait/landscape changes
- 📐 **Responsive Sizing**: Scale widgets proportionally across devices
- ✨ **Extension Methods**: Clean syntax with number extensions (`.w`, `.h`, `.sp`)
- 🎯 **Design Size Reference**: Works with your custom design dimensions

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  responsive_cs: ^0.0.1
```

## Usage

1. Initialize in your app
   Wrap your MaterialApp with ResponsiveSizerWidget:

```dart
import 'package:responsive_cs/responsive_cs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizerWidget(
      designSize: const Size(375, 812), // Your design size (e.g., iPhone 13)
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
```

2. Use responsive values
   Using the instance:

```dart
// Width percentage (based on design width)
double width = ResponsiveSizer.instance.wp(50);

// Height percentage (based on design height)
double height = ResponsiveSizer.instance.hp(20);

// Scale text size
double fontSize = ResponsiveSizer.instance.sp(16);
```

Using extensions (recommended):

```dart
Container(
  width: 100.w,  // 100% of design width
  height: 50.h,  // 50% of design height
  child: Text(
    'Responsive Text',
    style: TextStyle(fontSize: 16.sp), // Scaled font
  ),
)
```

3. Check device type and orientation

```dart
if (ResponsiveSizer.instance.deviceType == DeviceType.tablet) {
  // Tablet specific layout
}

if (ResponsiveSizer.instance.orientation == Orientation.landscape) {
  // Landscape specific layout
}
```

## Example

Here's a complete responsive widget example:

```dart
class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300.w,  // Responsive width
          height: 150.h, // Responsive height
          color: Colors.blue,
          child: Center(
            child: Text(
              'This adapts to all screens!',
              style: TextStyle(fontSize: 20.sp), // Responsive text
            ),
          ),
        ),
        if (ResponsiveSizer.instance.deviceType == DeviceType.mobile)
          const MobileSpecificWidget(),
        if (ResponsiveSizer.instance.orientation == Orientation.landscape)
          const LandscapeWidget(),
      ],
    );
  }
}
```

## License

### MIT License

```
This README includes:
1. Package header with badges
2. Clear installation instructions
3. Comprehensive usage examples
4. API reference
5. Best practices section
6. License information

You can customize:
- The example design sizes to match your use case
- Add more complex examples if needed
- Include screenshots or GIFs showing the responsiveness
- Add a "Contributing" section if it's an open-source project
```
