import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';

class BriefingScreen extends StatefulWidget {
  const BriefingScreen({super.key});

  @override
  State<BriefingScreen> createState() => _BriefingScreenState();
}

class _BriefingScreenState extends State<BriefingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // toolbarHeight: 100,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: true,
        backgroundColor: ConstantColors.primaryColor1,
        title: const Text(
          'Briefing',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: ConstantColors.primaryColor3,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
