import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class bodyBackground extends StatelessWidget {
  const bodyBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'asset/images/background.svg',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        child
      ],
    );
  }
}
