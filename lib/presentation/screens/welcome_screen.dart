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
  void initState() {
    super.initState();
  }

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ~:Logo Section:~
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: ConstantColors.primaryColor1,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal:
                      (MediaQuery.of(context).size.width < 800) ? 8 : 24,
                  vertical: (MediaQuery.of(context).size.height < 800) ? 8 : 24,
                ),
                child: Image.asset(
                  'assets/images/logo 5.png',
                  fit: BoxFit.cover,
                  width: (MediaQuery.of(context).size.width < 800) ? 70 : 150,
                ),
              ),
            ),

            // ~:Welcome Statement:~
            Expanded(
              child: CustomCarousel.welcomeSlider(context),
            ),

            // ~:Button Section:~
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ~:Login Button:~
                  BlocBuilder<CarouselBloc, CarouselState>(
                    builder: (context, state) {
                      debugPrint('Current Index: ${state.currentIndex}');
                      if (state.currentIndex == 3) {
                        return CustomButton.primaryButton2(
                          context: context,
                          text: 'Login',
                          func: () => Navigator.pushNamed(context, '/login'),
                          bgColor: ConstantColors.primaryColor1,
                          textStyle: TextThemes.subtitle,
                          shadowColor: ConstantColors.shadowColor,
                        );
                      } else {
                        return CustomButton.primaryButton2(
                          context: context,
                          text: 'Login',
                          func: () {},
                          bgColor: ConstantColors.disabledColor,
                          textStyle: TextThemes.subtitle,
                          shadowColor: ConstantColors.shadowColor,
                        );
                      }
                    },
                  ),

                  // ~:Divider:~
                  const SizedBox(height: 10),

                  // ~:Sign Up Button:~
                  BlocBuilder<CarouselBloc, CarouselState>(
                    builder: (context, state) {
                      if (state.currentIndex == 3) {
                        return CustomButton.primaryButton2(
                          context: context,
                          text: 'Sign Up',
                          func: () => Navigator.pushNamed(context, '/register'),
                          bgColor: ConstantColors.primaryColor2,
                          textStyle: TextThemes.subtitle,
                          shadowColor: ConstantColors.shadowColor,
                        );
                      } else {
                        return CustomButton.primaryButton2(
                          context: context,
                          text: 'Sign Up',
                          func: () {},
                          bgColor: ConstantColors.disabledColor,
                          textStyle: TextThemes.subtitle,
                          shadowColor: ConstantColors.shadowColor,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
