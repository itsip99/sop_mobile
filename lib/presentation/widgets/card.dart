import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/models/report.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/source/leasing_source.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/source/payment_source.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/source/stu_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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
        borderRadius: BorderRadius.circular(radiusConfig),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 4.0,
          ),
        ],
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
          BoxShadow(
            color: ConstantColors.shadowColor,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        spacing: 8.0,
        children: [
          // ~:Card Header:~
          reportHeader(
            context,
            data,
          ),

          // ~:Card STU Section:~
          reportStuBody(
            context,
            data.stu,
          ),

          // ~:Card Payment Section:~
          reportPaymentBody(
            context,
            data.payment,
          ),

          // ~:Card Leasing Section:~
          reportLeasingBody(
            context,
            data.leasing,
          ),
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
              '${data.pic} as PIC',
              style: TextThemes.normal,
            ),
          ),

          // ~:View Salesman Button:~
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              '/sales',
              arguments: {
                'registeredSales': data.salesmen,
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
        Text(
          'STU Report',
          style: TextThemes.title2.copyWith(fontSize: 16),
        ),

        // ~:STU DataGrid:~
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.275,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SfDataGrid(
              footerHeight: 0.0,
              source: StuDataSource(
                stuData: data,
              ),
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
          'Payment Report',
          style: TextThemes.title2.copyWith(fontSize: 16),
        ),

        // ~:Payment DataGrid:~
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.225,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SfDataGrid(
              footerHeight: 0.0,
              source: PaymentDataSource(
                stuData: data,
              ),
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
          'Leasing Report',
          style: TextThemes.title2.copyWith(fontSize: 16),
        ),

        // ~:Leasing DataGrid:~
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.225,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SfDataGrid(
              footerHeight: 0.0,
              source: LeasingDataSource(
                stuData: data,
              ),
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
