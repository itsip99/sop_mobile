import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/buttons.dart';
import 'package:sop_mobile/presentation/widgets/snackbar.dart';
import 'package:sop_mobile/presentation/widgets/text.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  // bool _obscurePassword = true;
  // bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        CustomSnackbar.showSnackbar(
          context,
          'Passwords do not match',
          backgroundColor: ConstantColors.shadowColor,
        );
        return;
      }

      // If all validations pass, proceed with signup
      Navigator.pushReplacementNamed(context, '/login');

      CustomSnackbar.showSnackbar(
        context,
        'Signup successful, please wait for approval.',
        backgroundColor: ConstantColors.shadowColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ConstantColors.primaryColor1,
          child: Column(
            children: [
              // ~:AppBar:~
              AppBar(
                elevation: 0.0,
                scrolledUnderElevation: 0.0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(
                    Platform.isIOS
                        ? Icons.arrow_back_ios_new_rounded
                        : Icons.arrow_back_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // ~:Header Section:~
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  spacing: 10,
                  children: [
                    CustomText.title(text: 'Create Account'),
                    CustomText.subtitle(
                      text: 'Please fill in the form to continue',
                    ),
                  ],
                ),
              ),

              // ~:Form Section:~
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              // ~:Username Field:~
                              CustomTextFormField(
                                'your username',
                                'Username',
                                const Icon(Icons.person),
                                usernameController,
                                enableValidator: true,
                                validatorType: 'username',
                                textCapitalization:
                                    TextCapitalization.characters,
                                inputFormatters: [
                                  CapitalFormatter(),
                                  Formatter.capitalFormatter,
                                ],
                                borderRadius: 16,
                              ),

                              // ~:Email Field:~
                              CustomTextFormField(
                                'your email',
                                'Email',
                                const Icon(Icons.email),
                                emailController,
                                enableValidator: true,
                                validatorType: 'email',
                                borderRadius: 16,
                              ),

                              // ~:Password Field:~
                              CustomTextFormField(
                                'your password',
                                'Password',
                                const Icon(Icons.lock),
                                passwordController,
                                enableValidator: true,
                                validatorType: 'password',
                                borderRadius: 16,
                              ),

                              // ~:Confirm Password Field:~
                              CustomTextFormField(
                                'your confirm password',
                                'Confirm Password',
                                const Icon(Icons.lock),
                                confirmPasswordController,
                                enableValidator: true,
                                validatorType: 'confirmPassword',
                                borderRadius: 16,
                              ),

                              // ~:Sign Up Button:~
                              CustomButton.primaryButton2(
                                context: context,
                                text: 'Sign Up',
                                func: _submitForm,
                                bgColor: ConstantColors.primaryColor1,
                                textStyle: TextThemes.subtitle,
                                shadowColor: ConstantColors.shadowColor,
                              ),
                            ],
                          ),
                        ),

                        // ~:Login Link:~
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: Column(
                            spacing: 4,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText.footer(
                                text: 'Already have an account?',
                              ),
                              CustomText.footerButton(
                                text: 'Sign In',
                                pressedFunc: () =>
                                    Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
