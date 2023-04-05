import 'package:ash_app/controllers/login_controller.dart';
import 'package:ash_app/routes.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/custom_button.dart';
import 'package:ash_app/widget/custom_textform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GetBuilder<LoginController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 4.5,
                child: const Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  color: AppMainTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                hint: 'Email',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hint: 'Password',
                obscureText: true,
                controller: controller.passwordController,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: AppMainTheme.primaryAlignment,
                child: CustomButton(
                    onPressed: () {
                      controller.checkLogin();
                    },
                    title: 'Login'),
              ),
              const SizedBox(
                height: 45,
              ),
              Container(
                alignment: Alignment.center,
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color(0xffaaaaaa),
                    ),
                    children: [
                      const TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(GetRoutes.signup);
                          },
                        text: 'Sign up',
                        style: const TextStyle(
                          color: AppMainTheme.primaryColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      const TextHeightBehavior(applyHeightToFirstAscent: false),
                ),
              )
            ],
          ),
        );
      }),
    ));
  }
}
