import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/data/models/sales_import.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomFunctions {
  static Future<void> launchURL(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (context.mounted) {
        CustomSnackbar.showSnackbar(
          context,
          'Tidak dapat membuka tautan. Periksa URL dan coba lagi.',
          margin: 12,
          behavior: SnackBarBehavior.floating,
          radius: 16,
          backgroundColor: ConstantColors.shadowColor.shade300,
          iconColor: ConstantColors.primaryColor3,
          showCloseIcon: true,
        );
      }
    }
  }

  static void addSalesman(
    SalesmanBloc salesmanBloc,
    PanelController controller,
    List<NewSalesModel> sales,
  ) {
    for (var salesman in sales) {
      salesmanBloc.add(
        AddSalesman(
          Formatter.removeSpaces(salesman.id),
          Formatter.removeSpaces(salesman.name),
          Formatter.removeSpaces(salesman.tier),
          salesman.isActive,
        ),
      );
    }
    controller.close();
    salesmanBloc.add(FetchSalesman());
  }

  static void displayDialog(BuildContext context, Widget widget) {
    showDialog(
      context: context,
      builder: (context) {
        return widget;
      },
    );
  }
}
