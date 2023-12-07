import 'dart:async';

import 'package:fi_app/views/home_view/home_view.dart';
import 'package:fi_app/views/login_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  screenTime(BuildContext context) {
    final auth = FirebaseAuth.instance;

    var user = auth.currentUser;
    if (user == null) {
      return Timer(const Duration(seconds: 7), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    } else {
      return Timer(const Duration(seconds: 7), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }
}
