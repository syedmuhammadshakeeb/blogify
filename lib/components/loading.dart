import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Lottie.asset(
            'assets/lo.json',
            reverse: true,
            animate: true,
            repeat: true,
          ))
        ],
      ),
    );
  }
}
