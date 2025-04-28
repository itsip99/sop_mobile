import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void preprocessing() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (mounted) Navigator.pushReplacementNamed(context, '/welcome');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    preprocessing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: ConstantColors.primaryColor1,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ConstantColors.primaryColor1,
        child: Wrap(
          direction: Axis.vertical,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            Image.asset(
              'assets/images/figma.png',
              scale: 0.8,
              width: 200,
              height: 200,
            ),
            Builder(
              builder: (context) {
                if (Platform.isIOS) {
                  return const CupertinoActivityIndicator(
                    radius: 13,
                  );
                } else {
                  return const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.5,
                      color: Colors.black,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
