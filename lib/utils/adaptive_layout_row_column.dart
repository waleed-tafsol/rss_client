import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'context_utils.dart';

class AdaptiveLayoutRowColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment? alignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final double? widthBetween;
  final double? heightBetween;
  final MainAxisSize? size;
  final bool? expandedWidget;

  const AdaptiveLayoutRowColumn({
    super.key,
    required this.children,
    this.alignment,
    this.size,
    this.widthBetween,
    this.heightBetween,
    this.expandedWidget,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isLandscape) {
      final rowChildren = <Widget>[];
      for (var i = 0; i < children.length; i++) {
        if (i > 0) rowChildren.add(SizedBox(width: widthBetween ?? 20.w));
        if (expandedWidget == true) {
          rowChildren.add(Expanded(child: children[i]));
        } else {
          rowChildren.add(children[i]);
        }
      }
      return Row(
        mainAxisAlignment: alignment ?? MainAxisAlignment.start,
        mainAxisSize: size ?? MainAxisSize.max,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: rowChildren,
      );
    }
    final columnChildren = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) columnChildren.add(SizedBox(height: heightBetween ?? 20.sp));
      columnChildren.add(children[i]);
    }
    return Column(
      mainAxisAlignment: alignment ?? MainAxisAlignment.start,
      mainAxisSize: size ?? MainAxisSize.max,
      children: columnChildren,
    );
  }
}

class AdaptiveLayoutList extends StatelessWidget {
  final List<Widget> children;
  final double? horizontalHeight;
  final double? spaceHeight;
  final double? spaceWidth;
  final bool isScrollVertical;

  const AdaptiveLayoutList({
    super.key,
    required this.children,
    this.horizontalHeight,
    this.spaceHeight,
    this.spaceWidth,
    required this.isScrollVertical,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.isLandscape ? horizontalHeight : null,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: children.length,
        physics: context.isLandscape
            ? null
            : isScrollVertical
            ? const NeverScrollableScrollPhysics()
            : null,
        scrollDirection: context.isLandscape ? Axis.horizontal : Axis.vertical,
        itemBuilder: (context, index) {
          return children[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return context.isLandscape
              ? SizedBox(width: spaceWidth ?? 20.w)
              : SizedBox(height: spaceHeight ?? 20.sp);
        },
      ),
    );
  }
}

class AdaptiveLayoutListInverse extends StatelessWidget {
  final List<Widget> children;
  final double? horizontalHeight;

  final double? spaceHeight;
  final double? spaceWidth;

  final bool isScrollVertical;

  const AdaptiveLayoutListInverse({
    super.key,
    required this.children,
    this.horizontalHeight,
    this.spaceHeight,
    this.spaceWidth,
    required this.isScrollVertical,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.isLandscape ? null : horizontalHeight,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: children.length,
        physics: context.isLandscape
            ? (isScrollVertical ? const NeverScrollableScrollPhysics() : null)
            : null,
        scrollDirection: context.isLandscape ? Axis.vertical : Axis.horizontal,
        itemBuilder: (context, index) {
          return children[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return context.isLandscape
              ? SizedBox(height: spaceHeight ?? 20.sp)
              : SizedBox(width: spaceWidth ?? 20.w);
        },
      ),
    );
  }
}