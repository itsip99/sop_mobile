import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/filter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: Column(
          children: [
            // ~:Profile & Utility Section:~
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width < 800) ? 15 : 45,
                vertical: (MediaQuery.of(context).size.height < 800) ? 25 : 75,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ~:Profile Section:~
                  Expanded(
                    child: Wrap(
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        // ~:Profile Image:~
                        CircleAvatar(
                          backgroundColor: ConstantColors.primaryColor2,
                          radius: (MediaQuery.of(context).size.width < 800)
                              ? 30
                              : 50,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              'assets/images/figma.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                        // ~:Profile Name:~
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            // ~:Welcome Statement:~
                            const Text(
                              'Selamat datang,',
                              style: TextThemes.subtitle,
                            ),

                            // ~:Profile Name:~
                            BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginFailure) {
                                  Navigator.pushReplacementNamed(
                                      context, '/welcome');
                                }
                              },
                              builder: (context, state) {
                                if (state is LoginSuccess) {
                                  return Text(
                                    state.login.name,
                                    style: TextThemes.title2.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }

                                return const Text('Guest');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ~:Utility Section:~
                  // ~:Logout Button:~
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LogoutSuccess) {
                        Navigator.pushReplacementNamed(context, '/welcome');
                      } else if (state is LogoutFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.getLogoutFailure),
                            backgroundColor: ConstantColors.primaryColor3,
                          ),
                        );
                      }
                    },
                    child: IconButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(LogoutButtonPressed());
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: ConstantColors.primaryColor3,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ~:Main Section:~
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: ConstantColors.primaryColor2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      (MediaQuery.of(context).size.width < 800) ? 20 : 40,
                    ),
                    topRight: Radius.circular(
                      (MediaQuery.of(context).size.width < 800) ? 20 : 40,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal:
                      (MediaQuery.of(context).size.width < 800) ? 15 : 45,
                  vertical:
                      (MediaQuery.of(context).size.height < 800) ? 10 : 30,
                ),
                child: Column(
                  children: [
                    // ~:Filter Section:~
                    Filter.type1(context),

                    // ~:Acts Section:~
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: const SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
