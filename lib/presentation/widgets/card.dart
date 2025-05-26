import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class CustomCard {
  static Widget briefSection(
    final BuildContext context,
    final double boxWidth,
    final double boxHeight,
    final ScrollController scrollController,
    final List<BriefingModel> briefingData,
    final double cardWidth,
    final double cardHeight, {
    final ScrollPhysics scrollBehavior = const NeverScrollableScrollPhysics(),
    final Alignment cardAlignment = Alignment.center,
    final Color cardBorderColor = ConstantColors.primaryColor3,
    final Color cardBackgroundColor = ConstantColors.primaryColor2,
    final Color cardShadowColor = ConstantColors.shadowColor,
    final ScrollPhysics cardScrollBehavior =
        const NeverScrollableScrollPhysics(),
    final double cardBorderWidth = 1.5,
    final double cardMargin = 0.0,
  }) {
    return SizedBox(
      width: boxWidth,
      height: boxHeight,
      child: ListView.builder(
        physics: scrollBehavior,
        controller: scrollController,
        itemCount: briefingData.length,
        itemBuilder: (context, index) {
          final data = briefingData[index];

          return card(
            context,
            cardWidth,
            cardHeight,
            cardAlignment,
            cardBorderColor,
            cardBackgroundColor,
            cardShadowColor,
            cardScrollBehavior,
            borderWidth: cardBorderWidth,
            marginConfig: cardMargin,
            [
              brief(
                context,
                'Lokasi',
                data.location,
                padHorizontal: 8,
              ),

              brief(
                context,
                'Peserta',
                '${data.participants} orang',
                padHorizontal: 8,
              ),

              brief(
                context,
                'Shop Manager',
                '${data.shopManager} orang',
                padHorizontal: 8,
              ),

              brief(
                context,
                'Sales Counter',
                '${data.salesCounter} orang',
                padHorizontal: 8,
              ),

              brief(
                context,
                'Salesman',
                '${data.salesman} orang',
                padHorizontal: 8,
              ),

              brief(
                context,
                'Others',
                '${data.others} orang',
                padHorizontal: 8,
              ),

              brief(
                context,
                'Description',
                data.topic,
                isHorizontal: false,
                padHorizontal: 8,
              ),

              // ~:Image:~
              button(
                context,
                () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return Dialog(
                  //       backgroundColor:
                  //           ConstantColors
                  //               .primaryColor2,
                  //       child: ClipRRect(
                  //         borderRadius:
                  //             BorderRadius
                  //                 .circular(
                  //                     16),
                  //         child: Image
                  //             .memory(
                  //           base64Decode(
                  //             briefing
                  //                 .pic,
                  //           ),
                  //           fit: BoxFit
                  //               .contain,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                },
                MediaQuery.of(context).size.width,
                30,
                Alignment.center,
                'Lihat Gambar',
                TextThemes.normal,
                ConstantColors.primaryColor1,
                8,
                8,
                20,
              ),
            ],
          );
        },
      ),
    );
  }

  static Widget card(
    BuildContext context,
    double widthConfig,
    double heightConfig,
    AlignmentGeometry alignmentConfig,
    Color borderColor,
    Color backgroundColor,
    Color shadowColor,
    ScrollPhysics physicsConfig,
    List<Widget> children, {
    double borderWidth = 1.0,
    double radiusConfig = 20.0,
    double paddingConfig = 8,
    double marginConfig = 8,
    double verticalDivider = 8.0,
  }) {
    return Container(
      width: widthConfig,
      height: heightConfig,
      alignment: alignmentConfig,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(radiusConfig),
      ),
      padding: EdgeInsets.all(paddingConfig),
      margin: EdgeInsets.all(marginConfig),
      child: SingleChildScrollView(
        physics: physicsConfig,
        child: Wrap(
          runSpacing: verticalDivider,
          children: [...children],
        ),
      ),
    );
  }

  static Widget brief(
    BuildContext context,
    String title,
    String content, {
    bool isHorizontal = true,
    double padVertical = 4,
    double padHorizontal = 4,
  }) {
    if (isHorizontal) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: padVertical,
          horizontal: padHorizontal,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextThemes.normal,
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: TextThemes.normal,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: padVertical,
          horizontal: padHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextThemes.normal,
              textAlign: TextAlign.start,
            ),
            Text(
              content,
              style: TextThemes.normal,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      );
    }
  }

  static Widget button(
    BuildContext context,
    Function func,
    double buttonWidth,
    double buttonHeigth,
    AlignmentGeometry textAlignment,
    String text,
    TextStyle style,
    Color buttonColor,
    double verticalPadding,
    double horizontalPadding,
    double radius,
  ) {
    return ElevatedButton(
      onPressed: () => func(),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Container(
        width: buttonWidth,
        height: buttonHeigth,
        alignment: textAlignment,
        child: Text(text, style: style),
      ),
    );
  }
}
