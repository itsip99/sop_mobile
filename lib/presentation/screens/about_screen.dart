import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: true,
          backgroundColor: ConstantColors.primaryColor2,
          leading: Builder(
            builder: (context) {
              if (Platform.isIOS) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 15),
                  onPressed: () => Navigator.pop(context),
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  onPressed: () => Navigator.pop(context),
                );
              }
            },
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ConstantColors.primaryColor2,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/corp_logo.png',
                  scale: 0.8,
                  width: 175,
                  height: 175,
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  spacing: 12,
                  children: [
                    Text('Version 1.0.0', style: TextThemes.normal),

                    SizedBox(
                      width: 250,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: '©2025 ', style: TextThemes.normal),
                            TextSpan(
                              text: 'Basra Corporation',
                              style: TextThemes.normal.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' developed by ',
                              style: TextThemes.normal,
                            ),
                            TextSpan(
                              text: 'Joseph Angelus',
                              style: TextThemes.normal.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: ' & ', style: TextThemes.normal),
                            TextSpan(
                              text: 'Joseano Jeffry',
                              style: TextThemes.normal.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
