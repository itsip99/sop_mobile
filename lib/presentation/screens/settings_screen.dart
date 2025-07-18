import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/functions.dart';
import 'package:sop_mobile/presentation/widgets/snackbar.dart';
import 'package:sop_mobile/presentation/widgets/text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

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
          title: const Text('Pengaturan', style: TextThemes.subtitle),
          centerTitle: true,
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
            spacing: 8,
            children: [
              // ~:Privacy Policy:~
              CustomText.horizontalAlignment(
                'Privasi Akun',
                isIcon: true,
                icon: Icons.open_in_new,
                onTap:
                    () => CustomFunctions.launchURL(
                      context,
                      'https://yamaha-jatim.co.id/PrivacyPolicySOPMobile.html',
                    ),
              ),

              // ~:User Manual:~
              CustomText.horizontalAlignment(
                'Panduan Penggunaan',
                isIcon: true,
                icon: Icons.open_in_new,
                onTap:
                    () => CustomFunctions.launchURL(
                      context,
                      'https://www.canva.com/design/DAGtNJbZKKc/6f3Bnf4WAIdUiXZM_aC9YQ/edit?utm_content=DAGtNJbZKKc&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton',
                    ),
              ),

              // ~:About App:~
              CustomText.horizontalAlignment(
                'Tentang Aplikasi',
                isIcon: true,
                icon: Icons.arrow_forward_ios,
                onTap: () => Navigator.pushNamed(context, '/about'),
              ),

              // ~:Logout Button:~
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LogoutSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/welcome',
                      (route) => false,
                    );
                  } else if (state is LogoutFailure) {
                    CustomSnackbar.showSnackbar(
                      context,
                      state.getLogoutFailure,
                      backgroundColor: ConstantColors.primaryColor3,
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(
                    onPressed: () => loginBloc.add(LogoutButtonPressed()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ConstantColors.primaryColor2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: ConstantColors.closeColor,
                          width: 2,
                        ),
                      ),
                    ),
                    child: const Text('Logout', style: TextThemes.logoutButton),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
