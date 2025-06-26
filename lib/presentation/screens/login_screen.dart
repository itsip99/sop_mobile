import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/buttons.dart';
import 'package:sop_mobile/presentation/widgets/logo.dart';
import 'package:sop_mobile/presentation/widgets/snackbar.dart';
import 'package:sop_mobile/presentation/widgets/text.dart';
import 'package:sop_mobile/presentation/widgets/textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: ConstantColors.primaryColor1,
        leading: Builder(
          builder: (context) {
            if (Platform.isIOS) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            }
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ConstantColors.primaryColor1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ~:Header:~
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Wrap(
                spacing: 15,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // ~:Logo Section:~
                  Logo.rounded1(context, 'assets/images/logo.png', 88, 88),

                  // ~:Welcome Statement:~
                  Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      // ~:Welcome Subtitle:~
                      CustomText.subtitle(text: 'Welcome back to'),

                      // ~:Welcome Title:~
                      Wrap(
                        spacing: -8,
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          CustomText.title(text: 'SOP Mobile'),
                          CustomText.subtitle(
                            text: 'v1.0.0',
                            themes: TextThemes.normal,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ~:Body:~
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: ConstantColors.primaryColor2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.shortestSide >= 600 ? 60 : 20,
                  MediaQuery.of(context).size.shortestSide >= 600 ? 75 : 25,
                  MediaQuery.of(context).size.shortestSide >= 600 ? 60 : 20,
                  MediaQuery.of(context).size.shortestSide >= 600 ? 45 : 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ~:Body Content:~
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Wrap(
                          runSpacing: 10,
                          children: [
                            // ~:Login Section:~
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ~:Login Title:~
                                  CustomText.title(text: 'Login'),

                                  // ~:Login Subtitle:~
                                  CustomText.subtitle(
                                    text: 'Please enter your credentials',
                                  ),
                                ],
                              ),
                            ),

                            // ~:Login Form:~
                            Column(
                              spacing: 8,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ~:Username TextField:~
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

                                // ~:Password TextField:~
                                CustomTextFormField(
                                  'your password',
                                  'Password',
                                  const Icon(Icons.lock),
                                  passwordController,
                                  isPassword: true,
                                  enableValidator: true,
                                  validatorType: 'password',
                                  inputFormatters: [Formatter.normalFormatter],
                                  borderRadius: 16,
                                  showPassword: true,
                                ),
                              ],
                            ),

                            // ~:Divider:~
                            const SizedBox(height: 15),

                            // ~:Button Section:~
                            BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginSuccess) {
                                  log('Login Success.');
                                  // log(state.login);
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/home',
                                    (route) => false,
                                  );
                                } else if (state is LoginFailure) {
                                  log('Login Failed: ${state.error}');
                                  CustomSnackbar.showSnackbar(
                                    context,
                                    state.error,
                                    backgroundColor: ConstantColors.shadowColor,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is LoginLoading) {
                                  return CustomButton.primaryButton2(
                                    context: context,
                                    text: 'Sign In',
                                    func: () => context.read<LoginBloc>().add(
                                          LoginButtonPressed(
                                            username: usernameController.text,
                                            password: passwordController.text,
                                          ),
                                        ),
                                    bgColor: ConstantColors.primaryColor1,
                                    textStyle: TextThemes.subtitle,
                                    shadowColor: ConstantColors.shadowColor,
                                    height: 40,
                                    isLoading: true,
                                  );
                                } else {
                                  return CustomButton.primaryButton2(
                                    context: context,
                                    text: 'Sign In',
                                    func: () => context.read<LoginBloc>().add(
                                          LoginButtonPressed(
                                            username: usernameController.text,
                                            password: passwordController.text,
                                          ),
                                        ),
                                    bgColor: ConstantColors.primaryColor1,
                                    textStyle: TextThemes.subtitle,
                                    shadowColor: ConstantColors.shadowColor,
                                    height: 40,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ~:Body Footer:~
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: Column(
                        spacing: 4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ~:Footer Title~:
                          CustomText.footer(
                            text: 'Don\'t have an account?',
                          ),

                          // ~:Footer Button:~
                          CustomText.footerButton(
                            text: 'Sign Up',
                            pressedFunc: () => Navigator.pushReplacementNamed(
                              context,
                              '/register',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
