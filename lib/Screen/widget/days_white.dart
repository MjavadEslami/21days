import 'package:flutter/material.dart';

class DaysWhite extends StatelessWidget {
  const DaysWhite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -40,
      top: -10,
      child: Transform.rotate(
        angle: 800 / 1,
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(8 / 5),
          child: Hero(
            tag: 'new-habbits',
            child: Image.asset(
              'assets/images/logo-w.png',
              width: 250,
            ),
          ),
        ),
      ),
    );
  }
}
