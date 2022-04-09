import 'package:flutter/material.dart';

const Radius borderRadius = Radius.circular(10);

/// Show a modal as bottom sheet.
Future<T?> showModal<T>({
  required BuildContext context,
  required Widget child,
  double maxHeight = 300,
  double minHeight = 150,
  bool enableDrag = true,
  Color backgroundColor = Colors.white,
  bool isFullScreen = false,
}) {
  final fullScreenHeight = MediaQuery.of(context).size.height;
  final allowance = MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: borderRadius,
        topRight: borderRadius,
      ),
    ),
    enableDrag: enableDrag,
    isDismissible: true,
    backgroundColor: backgroundColor,
    barrierColor: Colors.black.withOpacity(0.2),
    clipBehavior: Clip.hardEdge,
    constraints: BoxConstraints(
      maxHeight: isFullScreen ? fullScreenHeight - allowance : maxHeight,
      minHeight: minHeight,
    ),
    builder: (_) => child,
  );
}
