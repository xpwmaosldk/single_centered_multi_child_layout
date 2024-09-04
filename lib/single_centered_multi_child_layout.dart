library centered_multi_child_layout;

import 'package:flutter/widgets.dart';

/// A [MultiChildLayoutDelegate] that positions children in a centered layout
/// with optional gaps around the centered widget.
class CenteredLayoutDelegate extends MultiChildLayoutDelegate {
  /// The gap between the top widget and the centered widget. Default is 0.
  final double topGap;

  /// The gap between the bottom widget and the centered widget. Default is 0.
  final double bottomGap;

  /// The gap between the left widget and the centered widget. Default is 0.
  final double leftGap;

  /// The gap between the right widget and the centered widget. Default is 0.
  final double rightGap;

  /// Creates a [CenteredLayoutDelegate] with optional gap parameters.
  /// All gaps default to 0 if not provided.
  CenteredLayoutDelegate({
    this.topGap = 0,
    this.bottomGap = 0,
    this.leftGap = 0,
    this.rightGap = 0,
  });

  @override
  void performLayout(Size size) {
    // Layout the centered child
    final sizeCentered = layoutChild('centered', BoxConstraints.loose(size));
    final centerX = (size.width - sizeCentered.width) / 2;
    final centerY = (size.height - sizeCentered.height) / 2;
    positionChild('centered', Offset(centerX, centerY));

    // Layout the bottom widget if it exists
    if (hasChild('bottom')) {
      final sizeBottom = layoutChild('bottom', BoxConstraints.loose(size));
      positionChild(
        'bottom',
        Offset((size.width - sizeBottom.width) / 2,
            centerY + sizeCentered.height + bottomGap),
      );
    }

    // Layout the top widget if it exists
    if (hasChild('top')) {
      final sizeTop = layoutChild('top', BoxConstraints.loose(size));
      positionChild(
        'top',
        Offset((size.width - sizeTop.width) / 2,
            centerY - sizeTop.height - topGap),
      );
    }

    // Layout the left widget if it exists
    if (hasChild('left')) {
      final sizeLeft = layoutChild('left', BoxConstraints.loose(size));
      positionChild(
        'left',
        Offset(centerX - sizeLeft.width - leftGap, centerY),
      );
    }

    // Layout the right widget if it exists
    if (hasChild('right')) {
      positionChild(
        'right',
        Offset(centerX + sizeCentered.width + rightGap, centerY),
      );
    }
  }

  @override
  bool shouldRelayout(covariant CenteredLayoutDelegate oldDelegate) =>
      topGap != oldDelegate.topGap ||
      bottomGap != oldDelegate.bottomGap ||
      leftGap != oldDelegate.leftGap ||
      rightGap != oldDelegate.rightGap;
}

/// A layout widget that positions the given widgets at the center.
/// This widget allows for a central widget and optionally top, bottom, left, and right widgets.
class SingleCenteredMultiChildLayout extends StatelessWidget {
  /// The widget to be positioned at the center.
  final Widget centeredWidget;

  /// An optional widget to be positioned at the bottom.
  final Widget? bottomWidget;

  /// An optional widget to be positioned at the top.
  final Widget? topWidget;

  /// An optional widget to be positioned on the left.
  final Widget? leftWidget;

  /// An optional widget to be positioned on the right.
  final Widget? rightWidget;

  /// The gap between the top widget and the centered widget. Default is 0.
  final double topGap;

  /// The gap between the bottom widget and the centered widget. Default is 0.
  final double bottomGap;

  /// The gap between the left widget and the centered widget. Default is 0.
  final double leftGap;

  /// The gap between the right widget and the centered widget. Default is 0.
  final double rightGap;

  /// Constructor for [SingleCenteredMultiChildLayout].
  /// [centeredWidget] is required, while the other widgets and gaps are optional.
  const SingleCenteredMultiChildLayout(
    this.centeredWidget, {
    this.bottomWidget,
    this.topWidget,
    this.leftWidget,
    this.rightWidget,
    this.topGap = 0,
    this.bottomGap = 0,
    this.leftGap = 0,
    this.rightGap = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: CenteredLayoutDelegate(
        topGap: topGap,
        bottomGap: bottomGap,
        leftGap: leftGap,
        rightGap: rightGap,
      ),
      children: [
        LayoutId(id: 'centered', child: centeredWidget),
        if (bottomWidget != null) LayoutId(id: 'bottom', child: bottomWidget!),
        if (topWidget != null) LayoutId(id: 'top', child: topWidget!),
        if (leftWidget != null) LayoutId(id: 'left', child: leftWidget!),
        if (rightWidget != null) LayoutId(id: 'right', child: rightWidget!),
      ],
    );
  }
}
