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
          children: [
            // ~:Header:~
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 125,
              child: Wrap(
                spacing: 15,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  // ~:Logo Section:~
                  Logo.rounded1(
                    context,
                    'assets/images/figma.png',
                  ),

                  // ~:Welcome Statement:~
                  Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      // ~:Welcome Subtitle:~
                      CustomText.subtitle(text: 'Welcome back to'),

                      // ~:Welcome Title:~
                      CustomText.title(text: 'SOP Mobile'),
                    ],
                  ),
                ],
              ),
            ),

            // ~:Divider:~
            const SizedBox(height: 15),

            // ~:Body:~
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: ConstantColors.primaryColor3,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  (MediaQuery.of(context).size.width < 800) ? 20 : 60,
                  (MediaQuery.of(context).size.height < 800) ? 25 : 75,
                  (MediaQuery.of(context).size.width < 800) ? 20 : 60,
                  (MediaQuery.of(context).size.height < 800) ? 15 : 45,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ~:Body Content:~
                    Expanded(
                      child: Column(
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

                          // ~:Divider:~
                          const SizedBox(height: 10),

                          // ~:Login Form:~
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ~:Email TextField:~
                              CustomTextFormField(
                                'your username',
                                'Username',
                                const Icon(Icons.person),
                                usernameController,
                                enableValidator: true,
                                validatorType: 'username',
                                enableUpperCaseText: true,
                                inputFormatters: [
                                  CapitalFormatter(),
                                  Formatter.capitalFormatter,
                                ],
                              ),

                              // ~:Divider:~
                              const SizedBox(height: 10),

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
                              ),
                            ],
                          ),

                          // ~:Divider:~
                          const SizedBox(height: 15),

                          // ~:Button Section:~
                          BlocListener<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginLoading) {
                                log('Loading...');
                              } else if (state is LoginSuccess) {
                                log('Login Success.');
                                // log(state.login);
                                Navigator.pushNamed(context, '/home');
                              } else if (state is LoginFailure) {
                                log('Login Failed: ${state.error}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.error),
                                  ),
                                );
                              }
                            },
                            child: CustomButton.primaryButton2(
                              context: context,
                              text: 'Sign In',
                              func: () => context.read<LoginBloc>().add(
                                    LoginButtonPressed(
                                      usernameController.text,
                                      passwordController.text,
                                    ),
                                  ),
                              bgColor: ConstantColors.primaryColor1,
                              textStyle: TextThemes.subtitle,
                              shadowColor: ConstantColors.shadowColor,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ~:Body Footer:~
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
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
