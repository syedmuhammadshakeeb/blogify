import 'package:fi_app/components/botton.dart';
import 'package:fi_app/components/customtextfield.dart';
import 'package:fi_app/views/login_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  bool obscure = false;
  bool loading = true;
  final formkey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SignIn() {
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Text(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Form(
          key: formkey,
          child: Scaffold(
              body: loading
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .10,
                            ),
                            const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                                'Create an account to access all the features of Maxpense!',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            CustomTextFiels(
                              text: 'Email',
                              controller: emailcontroller,
                              obscure: false,
                              suicon: null,
                              icon: const Icon(
                                Icons.email_rounded,
                                color: Colors.blueAccent,
                              ),
                              title: 'Enter Email',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            CustomTextFiels(
                              text: 'Password',
                              controller: passwordcontroller,
                              obscure: obscure,
                              suicon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                child: Icon(
                                  obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.blueAccent,
                              ),
                              title: 'Enter password',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Confirm password',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            CustomTextFiels(
                              text: 'Confirm Password',
                              controller: confirmpasswordcontroller,
                              obscure: obscure,
                              suicon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                child: Icon(
                                  obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.blueAccent,
                              ),
                              title: 'Confirm password',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  SignIn();
                                }
                              },
                              child: CustomBotton(
                                text: 'Sign in ',
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.black,
                              height: 2,
                              indent: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                    },
                                    child: const Text('Login',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                        )))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Lottie.asset('assets/lo.json', repeat: true))),
        ),
      ),
    );
  }
}
