import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_bloc.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_event.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class CustomCarousel {
  static Widget primaryStructure({
    required BuildContext context,
    required String imgPath,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // ~:Welcome Image:~
        Image.asset(
          imgPath,
          fit: BoxFit.contain,
          height: (MediaQuery.of(context).size.height < 800)
              ? 300
              : MediaQuery.of(context).size.height * 0.45,
        ),

        // ~:Welcome Text:~
        Wrap(
          direction: Axis.vertical,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            // ~:Welcome Title:~
            Text(
              title,
              style: TextThemes.title1,
            ),
            // ~:Welcome Subtitle:~
            Text(
              subtitle,
              style: TextThemes.subtitle,
            ),
          ],
        ),
      ],
    );
  }

  static Widget welcomeSlider(BuildContext context) {
    final PageController carouselController = PageController();

    return Column(
      children: [
        // ~:Welcome Carousel:~
        Expanded(
          child: BlocBuilder<CarouselBloc, CarouselState>(
            builder: (context, state) {
              return PageView(
                controller: carouselController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  context.read<CarouselBloc>().add(
                        CarouselEvent(index),
                      );
                },
                children: [
                  // ~:Welcome Section:~
                  CustomCarousel.primaryStructure(
                    context: context,
                    imgPath: 'assets/images/welcome.png',
                    title: 'SOP Mobile',
                    subtitle: 'Empowering you with ease',
                  ),

                  // ~:Acts Section:~
                  CustomCarousel.primaryStructure(
                    context: context,
                    imgPath: 'assets/images/acts.png',
                    title: 'Easily',
                    subtitle: 'Input and create activities',
                  ),

                  // ~:Monitor Section:~
                  CustomCarousel.primaryStructure(
                    context: context,
                    imgPath: 'assets/images/monitor.png',
                    title: 'Monitor',
                    subtitle: 'Your own activities',
                  ),

                  // ~:Sales Section:~
                  CustomCarousel.primaryStructure(
                    context: context,
                    imgPath: 'assets/images/sales.png',
                    title: 'Adjust',
                    subtitle: 'Your manpower',
                  ),
                ],
              );
            },
          ),
        ),

        // ~:Carousel Indicator:~
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ~:Left Arrow:~
            const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
                color: ConstantColors.primaryColor1,
              ),
            ),

            // ~:Indicators:~
            BlocBuilder<CarouselBloc, CarouselState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: state.currentIndex == index ? 24.0 : 12.0,
                      height: 4.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 2,
                      ),
                      decoration: BoxDecoration(
                        color: state.currentIndex == index
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    );
                  }),
                );
              },
            ),

            // ~:Left Arrow:~
            const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: ConstantColors.primaryColor1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
