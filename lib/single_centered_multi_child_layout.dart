library single_centered_multi_child_layout;

import 'package:flutter/widgets.dart';

class MyLayoutDelegate extends MultiChildLayoutDelegate {
  final int gap;
  MyLayoutDelegate({this.gap = 0});
  @override
  void performLayout(Size size) {
    final sizeA = layoutChild('A', BoxConstraints.loose(size));
    positionChild(
      'A',
      Offset((size.width - sizeA.width) / 2, (size.height - sizeA.height) / 2),
    );

    if (hasChild('B')) {
      final sizeB = layoutChild('B', BoxConstraints.loose(size));
      positionChild(
        'B',
        Offset((size.width - sizeB.width) / 2,
            (size.height + sizeA.height) / 2 + gap),
      );
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}

class SingleCenteredMultiChildLayout extends StatelessWidget {
  final int gap;
  final Widget centeredWidget;
  final Widget? subWidget;
  const SingleCenteredMultiChildLayout(this.centeredWidget,
      {this.gap = 0, this.subWidget, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: MyLayoutDelegate(),
      children: [
        centeredWidget,
        if (subWidget != null) subWidget!,
      ],
    );
  }
}
