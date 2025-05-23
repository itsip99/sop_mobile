import 'package:sop_mobile/data/models/home.dart';

abstract class FilterRepo {
  Future<HomeModel> dataPreprocessing(
    bool isBriefAvailable,
    bool isReportAvailable,
    // bool isSalesAvailable,
    String date,
  );
  Future<Map<String, dynamic>> fetchBriefingData(String username, String date);
  Future<Map<String, dynamic>> fetchReportData(String username, String date);
  // Future<Map<String, dynamic>> fetchSalesData(String username, String date);
}
