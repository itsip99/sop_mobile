import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/models/report.dart';
import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/data/models/sales_import.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/data/repositories/storage.dart';
import 'package:sop_mobile/presentation/state/brief/brief_bloc.dart';
import 'package:sop_mobile/presentation/state/brief/brief_event.dart';
import 'package:sop_mobile/presentation/state/brief/brief_state.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/source/leasing_source.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/source/payment_source.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/source/stu_source.dart';
import 'package:sop_mobile/presentation/widgets/dialog.dart';
import 'package:sop_mobile/presentation/widgets/functions.dart';
import 'package:sop_mobile/presentation/widgets/loading.dart';
import 'package:sop_mobile/presentation/widgets/salesman_profile.dart';
import 'package:sop_mobile/presentation/widgets/snackbar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomCard {
  static Widget salesmanProfile(
    SalesmanBloc salesmanBloc,
    List<SalesModel> salesList, {
    bool isPreview = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        spacing: 8.0,
        children:
            salesList.map((SalesModel salesProfile) {
              return SalesmanProfileCard(
                salesman: salesProfile,
                onStatusChanged: (bool isActive) {
                  if (!isPreview) {
                    salesmanBloc.add(
                      ModifySalesmanStatus(
                        sales: NewSalesModel(
                          id: salesProfile.id,
                          name: salesProfile.userName,
                          tier: salesProfile.tierLevel,
                          isActive: isActive ? 1 : 0,
                        ),
                      ),
                    );
                  }
                },
                isPreview: isPreview,
              );
            }).toList(),
      ),
    );
  }

  // static Widget salesmanProfile(
  //   SalesmanBloc salesmanBloc,
  //   List<SalesModel> salesList,
  // ) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 12),
  //     child: Column(
  //       spacing: 8.0,
  //       children:
  //           salesList.map((SalesModel salesProfile) {
  //             return Card(
  //               color: ConstantColors.primaryColor2,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               elevation: 5,
  //               shadowColor: ConstantColors.shadowColor,
  //               child: ListTile(
  //                 contentPadding: const EdgeInsets.symmetric(
  //                   vertical: 4,
  //                   horizontal: 20,
  //                 ),
  //                 title: Text(
  //                   'ID ${Formatter.toTitleCase(salesProfile.id)}',
  //                   style: TextThemes.normal.copyWith(
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 subtitle: Text(
  //                   '${Formatter.toTitleCase(salesProfile.userName)} - ${Formatter.toTitleCase(salesProfile.tierLevel)}',
  //                   style: TextThemes.normal,
  //                 ),
  //                 trailing: BlocBuilder<SalesmanBloc, SalesmanState>(
  //                   buildWhen:
  //                       (previous, current) => current is! SalesmanLoading,
  //                   builder: (context, state) {
  //                     return AnimatedSwitcher(
  //                       duration: const Duration(milliseconds: 200),
  //                       transitionBuilder: (
  //                         Widget child,
  //                         Animation<double> animation,
  //                       ) {
  //                         return ScaleTransition(
  //                           scale: animation,
  //                           child: child,
  //                         );
  //                       },
  //                       child: Theme(
  //                         data: Theme.of(context).copyWith(
  //                           switchTheme: SwitchThemeData(
  //                             thumbColor: WidgetStateProperty.resolveWith<
  //                               Color
  //                             >((states) {
  //                               if (states.contains(WidgetState.selected)) {
  //                                 return Theme.of(context).colorScheme.primary;
  //                               }
  //                               return Theme.of(context).brightness ==
  //                                       Brightness.light
  //                                   ? Colors.grey.shade300
  //                                   : Colors.grey.shade600;
  //                             }),
  //                             trackColor:
  //                                 WidgetStateProperty.resolveWith<Color>((
  //                                   states,
  //                                 ) {
  //                                   if (states.contains(WidgetState.selected)) {
  //                                     return Theme.of(context)
  //                                         .colorScheme
  //                                         .primary
  //                                         .withValues(alpha: 0.5);
  //                                   }
  //                                   return Theme.of(context).brightness ==
  //                                           Brightness.light
  //                                       ? Colors.grey.shade400
  //                                       : Colors.grey.shade700;
  //                                 }),
  //                             materialTapTargetSize:
  //                                 MaterialTapTargetSize.shrinkWrap,
  //                           ),
  //                         ),
  //                         child: Switch(
  //                           key: ValueKey<bool>(salesProfile.isActive == 1),
  //                           value: salesProfile.isActive == 1,
  //                           onChanged: (bool value) {
  //                             salesmanBloc.add(
  //                               ModifySalesmanStatus(
  //                                 sales: NewSalesModel(
  //                                   id: salesProfile.id,
  //                                   name: salesProfile.userName,
  //                                   tier: salesProfile.tierLevel,
  //                                   isActive: value ? 1 : 0,
  //                                 ),
  //                               ),
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //     ),
  //   );
  // }

  static Widget briefSection(
    final BuildContext context,
    final String currentDate,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            briefingData
                .asMap()
                .entries
                .map(
                  (e) => card(
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
                        e.value.location,
                        padHorizontal: 8,
                        padVertical: 2,
                      ),

                      brief(
                        context,
                        'Peserta',
                        '${e.value.participants} orang',
                        padHorizontal: 8,
                        padVertical: 2,
                      ),

                      brief(
                        context,
                        'Shop Manager',
                        '${e.value.shopManager} orang',
                        padHorizontal: 8,
                        padVertical: 2,
                      ),

                      brief(
                        context,
                        'Sales Counter',
                        '${e.value.salesCounter} orang',
                        padHorizontal: 8,
                        padVertical: 2,
                      ),

                      brief(
                        context,
                        'Salesman',
                        '${e.value.salesman} orang',
                        padHorizontal: 8,
                        padVertical: 2,
                      ),

                      brief(
                        context,
                        'Others',
                        '${e.value.others} orang',
                        padHorizontal: 8,
                        padVertical: 2,
                      ),

                      brief(
                        context,
                        'Description',
                        e.value.topic,
                        isHorizontal: false,
                        padHorizontal: 8,
                        padVertical: 2,
                      ),

                      // ~:Image:~
                      briefImageButton(
                        context,
                        () async {
                          UserCredsModel userCredentials =
                              await StorageRepoImp().getUserCredentials();

                          if (context.mounted) {
                            context.read<BriefBloc>().add(
                              BriefImageRetrieval(
                                userCredentials.username,
                                e.value.date,
                              ),
                            );
                          }
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
                  ),
                )
                .toList(),
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
        borderRadius: BorderRadius.circular(radiusConfig),
        color: backgroundColor,
        boxShadow: [BoxShadow(color: shadowColor, blurRadius: 4.0)],
      ),
      padding: EdgeInsets.all(paddingConfig),
      margin: EdgeInsets.all(marginConfig),
      child: SingleChildScrollView(
        physics: physicsConfig,
        child: Column(spacing: verticalDivider, children: [...children]),
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
            Text(title, style: TextThemes.normal, textAlign: TextAlign.start),
            Text(content, style: TextThemes.normal, textAlign: TextAlign.start),
          ],
        ),
      );
    }
  }

  static Widget briefImageButton(
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
      onPressed: () async => await func(),
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
        child: BlocConsumer<BriefBloc, BriefState>(
          listener: (context, state) {
            if (state is BriefImageRetrievalSuccess) {
              CustomFunctions.displayDialog(
                context,
                CustomDialog.viewBriefImage(context, state.image),
              );
            } else if (state is BriefImageRetrievalFail) {
              CustomSnackbar.showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is BriefImageLoading) {
              return Loading.platformIndicator(
                iosRadius: 13,
                iosCircleColor: ConstantColors.primaryColor3,
                androidWidth: 24,
                androidHeight: 24,
                androidStrokeWidth: 3.5,
                androidCircleColor: ConstantColors.primaryColor3,
              );
            } else {
              return Text(text, style: style);
            }
          },
        ),
      ),
    );
  }

  static Widget reportSection(
    final BuildContext context,
    final Color backgroundColor,
    final ReportModel data, {
    final double marginLength = 4.0,
    final double paddingLength = 8.0,
    final Color shadowColor = ConstantColors.shadowColor,
  }) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ConstantColors.primaryColor2,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: ConstantColors.shadowColor, blurRadius: 4),
        ],
      ),
      child: Column(
        spacing: 8.0,
        children: [
          // ~:Card Header:~
          reportHeader(context, data),

          // ~:Card STU Section:~
          reportStuBody(context, data.stu),

          // ~:Card Payment Section:~
          reportPaymentBody(context, data.payment),

          // ~:Card Leasing Section:~
          reportLeasingBody(context, data.leasing),
        ],
      ),
    );
  }

  static Widget reportHeader(
    final BuildContext context,
    final ReportModel data, {
    final double horizontalPadding = 12.0,
    final double verticalPadding = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        children: [
          // ~:PIC Section:~
          Expanded(
            child: Text(
              'PIC: ${Formatter.toTitleCase(data.pic)}',
              style: TextThemes.normal.copyWith(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // ~:View Salesman Button:~
          TextButton(
            onPressed:
                () => Navigator.pushNamed(
                  context,
                  '/sales',
                  arguments: {
                    'registeredSales':
                        data.salesmen
                            .map((e) => SalesModel.fromSalesmanModel(e))
                            .toList(),
                  },
                ),
            child: const Text(
              'Lihat Salesman',
              style: TextThemes.styledTextButton,
            ),
          ),
        ],
      ),
    );
  }

  static Widget reportStuBody(
    final BuildContext context,
    final List<StuModel> data,
  ) {
    return Column(
      spacing: 8,
      children: [
        // ~:STU Header:~
        Text('Laporan STU', style: TextThemes.title2.copyWith(fontSize: 16)),

        // ~:STU DataGrid:~
        SizedBox(
          height:
              data.length > 3 ? 205 + (50 * (data.length - 3)).toDouble() : 205,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SfDataGrid(
              footerHeight: 0.0,
              source: StuDataSource(stuData: data),
              columnWidthMode: ColumnWidthMode.none,
              headerGridLinesVisibility: GridLinesVisibility.both,
              gridLinesVisibility: GridLinesVisibility.both,
              horizontalScrollPhysics: const BouncingScrollPhysics(),
              verticalScrollPhysics: const NeverScrollableScrollPhysics(),
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'header',
                  width: 75,
                  label: Center(
                    child: Text(
                      '',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'result',
                  width: 50,
                  label: Center(
                    child: Text(
                      'Result',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'target',
                  width: 50,
                  label: Center(
                    child: Text(
                      'Target',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'ach',
                  width: 75,
                  label: Center(
                    child: Text(
                      'Ach (%)',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'lm',
                  width: 50,
                  label: Center(
                    child: Text(
                      'LM',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'growth',
                  width: 75,
                  label: Center(
                    child: Text(
                      'Growth (%)',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget reportPaymentBody(
    final BuildContext context,
    final List<PaymentModel> data,
  ) {
    return Column(
      spacing: 8,
      children: [
        // ~:Payment Header:~
        Text(
          'Laporan Payment',
          style: TextThemes.title2.copyWith(fontSize: 16),
        ),

        // ~:Payment DataGrid:~
        SizedBox(
          // height: MediaQuery.of(context).size.height * 0.225,
          height:
              data.length > 2 ? 155 + (50 * (data.length - 2)).toDouble() : 155,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SfDataGrid(
              footerHeight: 0.0,
              source: PaymentDataSource(stuData: data),
              columnWidthMode: ColumnWidthMode.fill,
              headerGridLinesVisibility: GridLinesVisibility.both,
              gridLinesVisibility: GridLinesVisibility.both,
              horizontalScrollPhysics: const BouncingScrollPhysics(),
              verticalScrollPhysics: const NeverScrollableScrollPhysics(),
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'header',
                  width: 75,
                  label: Center(
                    child: Text(
                      '',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'result',
                  label: Center(
                    child: Text(
                      'Result',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'lm',
                  label: Center(
                    child: Text(
                      'LM',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'growth',
                  label: Center(
                    child: Text(
                      'Growth (%)',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget reportLeasingBody(
    final BuildContext context,
    final List<LeasingModel> data,
  ) {
    return Column(
      spacing: 8,
      children: [
        // ~:Leasing Header:~
        Text(
          'Laporan Leasing',
          style: TextThemes.title2.copyWith(fontSize: 16),
        ),

        // ~:Leasing DataGrid:~
        SizedBox(
          // height: MediaQuery.of(context).size.height * 0.225,
          height:
              data.length > 3 ? 205 + (50 * (data.length - 3)).toDouble() : 205,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SfDataGrid(
              footerHeight: 0.0,
              source: LeasingDataSource(stuData: data),
              columnWidthMode: ColumnWidthMode.fill,
              headerGridLinesVisibility: GridLinesVisibility.both,
              gridLinesVisibility: GridLinesVisibility.both,
              horizontalScrollPhysics: const BouncingScrollPhysics(),
              verticalScrollPhysics: const NeverScrollableScrollPhysics(),
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'header',
                  width: 75,
                  label: Center(
                    child: Text(
                      '',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'open',
                  width: 60,
                  label: Center(
                    child: Text(
                      'Terbuka',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'accepted',
                  width: 60,
                  label: Center(
                    child: Text(
                      'Diterima',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'rejected',
                  width: 60,
                  label: Center(
                    child: Text(
                      'Ditolak',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'approved',
                  width: 75,
                  label: Center(
                    child: Text(
                      'Approved',
                      style: TextThemes.normal.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
