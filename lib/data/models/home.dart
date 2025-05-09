import 'package:sop_mobile/data/models/briefing.dart';

class HomeModel {
  List<BriefingModel> briefingData;
  List reportData;
  List salesData;

  HomeModel({
    required this.briefingData,
    required this.reportData,
    required this.salesData,
  });
}
