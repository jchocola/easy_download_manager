import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.2,
      height: size.width * 0.2,
      child: Image.asset(
        'assets/empty.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
