import 'package:ash_app/controllers/signup_controller.dart';
import 'package:ash_app/routes.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/custom_button.dart';
import 'package:ash_app/widget/custom_textform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GetBuilder<SignupController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 6,
                child: const Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              const Text(
                'Sign Up',
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
                hint: 'Full Name',
                controller: controller.nameController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hint: 'Address',
                controller: controller.addressController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hint: 'Contact',
                controller: controller.contactController,
              ),
              const SizedBox(
                height: 10,
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
                height: 10,
              ),
              CustomTextFormField(
                hint: 'Confirm Password',
                obscureText: true,
                controller: controller.confirmPasswordController,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: CustomButton(
                    onPressed: () {
                      controller.checkSignup();
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
                      fontSize: 17,
                      color: Color(0xffaaaaaa),
                    ),
                    children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAllNamed(GetRoutes.login);
                          },
                        text: 'Login',
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
