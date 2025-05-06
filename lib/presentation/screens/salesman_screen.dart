import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/route/route_bloc.dart';
import 'package:sop_mobile/presentation/state/route/route_event.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/routes.dart';

class SalesmanScreen extends StatefulWidget {
  const SalesmanScreen({super.key});

  @override
  State<SalesmanScreen> createState() => _SalesmanScreenState();
}

class _SalesmanScreenState extends State<SalesmanScreen> {
  final TextEditingController locationController = TextEditingController();

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
          'Salesman',
          style: TextThemes.subtitle,
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            if (Platform.isIOS) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 15,
                ),
                onPressed: () {
                  context.read<RouteBloc>().add(RoutePop(ConstantRoutes.home));
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
                  context.read<RouteBloc>().add(RoutePop(ConstantRoutes.home));
                  Navigator.pop(context);
                },
              );
            }
          },
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: ConstantColors.primaryColor1,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: ConstantColors.primaryColor2,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: const Wrap(
            runSpacing: 10,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ~:Page Title:~
                  Text(
                    'Informasi Sales',
                    style: TextThemes.subtitle,
                  ),

                  // ~:Page Description:~
                  Text(
                    'Masukkan data diri sales untuk pembuatan laporan harian.',
                    style: TextThemes.normal,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
