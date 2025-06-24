import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_bloc.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/buttons.dart';
import 'package:sop_mobile/presentation/widgets/carousel.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: ConstantColors.primaryColor2,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ConstantColors.primaryColor2,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ~:Logo Section:~
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: ConstantColors.primaryColor2,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: ConstantColors.shadowColor,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal:
                      MediaQuery.of(context).size.shortestSide >= 600 ? 20 : 4,
                  vertical:
                      MediaQuery.of(context).size.shortestSide >= 600 ? 20 : 4,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.shortestSide >= 600
                      ? 150
                      : 70, // Wider on tablets
                ),
              ),
            ),

            // ~:Welcome Statement:~
            Expanded(child: CustomCarousel.welcomeSlider(context)),

            // ~:Login Section:~
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BlocBuilder<CarouselBloc, CarouselState>(
                builder: (context, state) {
                  debugPrint('Current Index: ${state.currentIndex}');
                  if (state.currentIndex == 3) {
                    return CustomButton.primaryButton2(
                      context: context,
                      text: 'Lanjut',
                      func: () => Navigator.pushNamed(context, '/login'),
                      bgColor: ConstantColors.primaryColor1,
                      textStyle: TextThemes.subtitle,
                      shadowColor: ConstantColors.shadowColor,
                    );
                  } else {
                    return CustomButton.primaryButton2(
                      context: context,
                      text: 'Lanjut',
                      func: () {},
                      bgColor: ConstantColors.disabledColor,
                      textStyle: TextThemes.subtitle,
                      shadowColor: ConstantColors.shadowColor,
                    );
                  }
                },
              ),
              // child: Column(
              //   spacing: 10,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // ~:Login Button:~
              //     BlocBuilder<CarouselBloc, CarouselState>(
              //       builder: (context, state) {
              //         debugPrint('Current Index: ${state.currentIndex}');
              //         if (state.currentIndex == 3) {
              //           return CustomButton.primaryButton2(
              //             context: context,
              //             text: 'Login',
              //             func: () => Navigator.pushNamed(context, '/login'),
              //             bgColor: ConstantColors.primaryColor1,
              //             textStyle: TextThemes.subtitle,
              //             shadowColor: ConstantColors.shadowColor,
              //           );
              //         } else {
              //           return CustomButton.primaryButton2(
              //             context: context,
              //             text: 'Login',
              //             func: () {},
              //             bgColor: ConstantColors.disabledColor,
              //             textStyle: TextThemes.subtitle,
              //             shadowColor: ConstantColors.shadowColor,
              //           );
              //         }
              //       },
              //     ),

              //     // ~:Sign Up Button:~
              //     BlocBuilder<CarouselBloc, CarouselState>(
              //       builder: (context, state) {
              //         if (state.currentIndex == 3) {
              //           return CustomButton.primaryButton2(
              //             context: context,
              //             text: 'Sign Up',
              //             func: () => Navigator.pushNamed(context, '/register'),
              //             bgColor: ConstantColors.primaryColor2,
              //             textStyle: TextThemes.subtitle,
              //             shadowColor: ConstantColors.shadowColor,
              //           );
              //         } else {
              //           return CustomButton.primaryButton2(
              //             context: context,
              //             text: 'Sign Up',
              //             func: () {},
              //             bgColor: ConstantColors.disabledColor,
              //             textStyle: TextThemes.subtitle,
              //             shadowColor: ConstantColors.shadowColor,
              //           );
              //         }
              //       },
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
