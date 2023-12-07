import 'package:fi_app/components/botton.dart';
import 'package:fi_app/components/customtextfield.dart';
import 'package:fi_app/views/home_view/home_view.dart';
import 'package:fi_app/views/signup_view/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool obscure = false;
  final formkey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  login() {
    firebaseAuth
        .signInWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text)
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .10,
                ),
                const Text(
                  'Login',
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
                    'Login now to track all your expenses and income at a place!',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            obscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.blueAccent,
                          ),
                        ),
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.blueAccent,
                        ),
                        title: 'Enter password',
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: CustomBotton(
                    text: 'Login',
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
                      'Dont have an account?',
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
                                  builder: (context) => const SignupScreen()));
                        },
                        child: const Text('Sign in',
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
        ),
      ),
    );
  }
}
