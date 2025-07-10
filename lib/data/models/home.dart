import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/models/report.dart';
import 'package:sop_mobile/data/models/sales.dart';

class HomeModel {
  List<BriefingModel> briefingData;
  List<ReportModel> reportData;
  List<SalesModel> salesData;

  HomeModel({
    required this.briefingData,
    required this.reportData,
    this.salesData = const [],
  });
}
