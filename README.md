The usage of this is very simple. 
It allows you to fix one widget in the center and place other widgets above, below, to the left, and to the right of it. 
There’s no need to hide unnecessary widgets to align the same widget in the center on various dynamic screens.

It is very useful in the following situations.

https://github.com/user-attachments/assets/8ad29887-748e-400b-a65c-6adbaf41c354


-- APIs
```
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
```