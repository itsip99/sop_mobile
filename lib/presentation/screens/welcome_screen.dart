import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/provider.dart';
import 'package:provider/provider.dart';
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateManager>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: ConstantColors.primaryColor3,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ConstantColors.primaryColor3,
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
                      (MediaQuery.of(context).size.width < 800) ? 20 : 60,
                  vertical:
                      (MediaQuery.of(context).size.height < 800) ? 10 : 30,
                ),
                child: Image.asset(
                  'assets/images/figma.png',
                  fit: BoxFit.cover,
                  width: (MediaQuery.of(context).size.width < 800) ? 40 : 150,
                ),
              ),
            ),

            // ~:Welcome Statement:~
            Expanded(
              child: CustomCarousel.welcomeSlider(context, state),
            ),

            // ~:Button Section:~
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ~:Login Button:~
                  CustomButton.primaryButton(
                    context: context,
                    text: 'Login',
                    func: () => Navigator.pushNamed(context, '/login'),
                    bgColor: ConstantColors.primaryColor1,
                    textStyle: TextThemes.subtitle,
                    shadowColor: ConstantColors.shadowColor,
                  ),

                  // ~:Divider:~
                  const SizedBox(height: 10),

                  // ~:Sign Up Button:~
                  CustomButton.primaryButton(
                    context: context,
                    text: 'Sign Up',
                    func: () => Navigator.pushNamed(context, '/signin'),
                    bgColor: ConstantColors.primaryColor3,
                    textStyle: TextThemes.subtitle,
                    shadowColor: ConstantColors.shadowColor,
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
