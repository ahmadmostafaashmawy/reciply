import 'package:flutter/material.dart';
import 'package:reciply/constants/app_images.dart';

class BackgroundScaffold extends StatelessWidget {
  final String image;
  final Widget body;

  const BackgroundScaffold({
    Key? key,
    this.image = AppImages.food,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        buildBackground(MediaQuery.of(context).size),
        SafeArea(child: body)
      ],
    );
  }

  Widget buildBackground(Size size) {
    return Image.asset(
      image,
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
    );
  }
}
