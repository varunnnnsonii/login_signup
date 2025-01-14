import 'package:flutter/material.dart';

import 'Footer.dart';
import 'Form.dart';
import 'Header.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: const [
                FormHeaderWidget(
                  image: 'assets/images/Phone3.png',
                  title: "Get On Board!",
                  subTitle: "Create your profile to start your Journey.",
                  imageHeight: 0.15,
                ),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}