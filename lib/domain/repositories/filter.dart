import 'package:sop_mobile/data/models/home.dart';

abstract class FilterRepo {
  Future<HomeModel> dataPreprocessing(
    bool isBriefAvailable,
    bool isReportAvailable,
    bool isSalesAvailable,
  );
  Future<Map<String, dynamic>> fetchBriefingData(String username, String date);
}
