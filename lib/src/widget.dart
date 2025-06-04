import 'package:flutter/widgets.dart';
import 'package:responsive_cs/responsive_cs.dart';

class ResponsiveSizerWidget extends StatelessWidget {
  final Widget child;
  final Size designSize;

  const ResponsiveSizerWidget({Key? key, required this.child, required this.designSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ResponsiveSizer.init(context: context, designSize: designSize);
        return child;
      },
    );
  }
}
