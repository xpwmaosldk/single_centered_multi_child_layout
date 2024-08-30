library centered_multi_child_layout;

import 'package:flutter/widgets.dart';

class CenteredLayoutDelegate extends MultiChildLayoutDelegate {
  final double topGap;
  final double bottomGap;
  final double leftGap;
  final double rightGap;

  CenteredLayoutDelegate({
    this.topGap = 0,
    this.bottomGap = 0,
    this.leftGap = 0,
    this.rightGap = 0,
  });

  @override
  void performLayout(Size size) {
    final sizeCentered = layoutChild('centered', BoxConstraints.loose(size));
    final centerX = (size.width - sizeCentered.width) / 2;
    final centerY = (size.height - sizeCentered.height) / 2;
    positionChild(
      'centered',
      Offset(centerX, centerY),
    );

    if (hasChild('bottom')) {
      final sizeBottom = layoutChild('bottom', BoxConstraints.loose(size));
      positionChild(
        'bottom',
        Offset((size.width - sizeBottom.width) / 2,
            centerY + sizeCentered.height + bottomGap),
      );
    }

    if (hasChild('top')) {
      final sizeTop = layoutChild('top', BoxConstraints.loose(size));
      positionChild(
        'top',
        Offset((size.width - sizeTop.width) / 2,
            centerY - sizeTop.height - topGap),
      );
    }

    if (hasChild('left')) {
      final sizeLeft = layoutChild('left', BoxConstraints.loose(size));
      positionChild(
        'left',
        Offset(centerX - sizeLeft.width - leftGap, centerY),
      );
    }

    if (hasChild('right')) {
      final sizeRight = layoutChild('right', BoxConstraints.loose(size));
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

class CenteredMultiChildLayout extends StatelessWidget {
  final Widget centeredWidget;
  final Widget? bottomWidget;
  final Widget? topWidget;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final double topGap;
  final double bottomGap;
  final double leftGap;
  final double rightGap;

  const CenteredMultiChildLayout(
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
