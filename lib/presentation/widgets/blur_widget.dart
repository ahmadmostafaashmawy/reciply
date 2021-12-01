import 'dart:ui';

import 'package:flutter/material.dart';

class BlurWidget extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double sigmaX;
  final double sigmaY;

  const BlurWidget(
      {Key? key,
      required this.child,
      this.width = double.infinity,
      this.height = 50.0,
      this.sigmaX = 1.0,
      this.sigmaY = 1.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: SizedBox(
          width: width,
          child: Center(child: child),
        ),
      ),
    );
  }
}
