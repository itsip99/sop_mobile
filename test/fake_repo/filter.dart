import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/models/home.dart';
import 'package:sop_mobile/data/models/report.dart';
import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/domain/repositories/filter.dart';

class FakeFilterRepo implements FilterRepo {
  bool shouldSucceed = true;
  bool hasData = true;

  void setShouldSucceed(bool value) {
    shouldSucceed = value;
  }

  void setHasData(bool value) {
    hasData = value;
  }

  @override
  Future<HomeModel> dataPreprocessing(
    bool isBriefingActive,
    bool isReportActive,
    String date,
  ) async {
    // if (!shouldSucceed) {
    //   throw Exception('Failed to fetch data');
    // }

    // if (!hasData) {
    //   return HomeModel(
    //     briefingData: [],
    //     reportData: [],
    //     salesData: [],
    //   );
    // }

    // Return sample data based on active filters
    return HomeModel(
      briefingData:
          isBriefingActive
              ? [
                BriefingModel(
                  date: date,
                  location: 'Test Location',
                  participants: 0,
                  shopManager: 0,
                  salesCounter: 0,
                  salesman: 0,
                  others: 0,
                  topic: 'Test Topic',
                ),
              ]
              : [],
      reportData:
          isReportActive
              ? [
                ReportModel(
                  date: date,
                  userId: '1',
                  userName: 'Test User',
                  area: 'Test Area',
                  pic: 'Test PIC',
                  payment: [],
                  salesmen: [],
                  stu: [],
                  leasing: [],
                ),
              ]
              : [],
      salesData: [
        SalesModel(
          tierLevel: 'Gold',
          status: 1,
          userId: '1',
          id: '1',
          userName: 'Test Sales',
        ),
      ],
    );
  }

  @override
  Future<Map<String, dynamic>> fetchBriefingData(
    String date,
    String userId,
  ) async {
    if (!shouldSucceed) throw Exception('Failed to fetch briefing data');
    if (!hasData) return {'status': 'success', 'data': []};

    return {
      'status': 'success',
      'data': [
        {
          'date': date,
          'location': 'Test Location',
          'participants': 'Test Participants',
          'shopManager': 'Test Manager',
          'salesCounter': 'Test Counter',
          'salesman': 'Test Salesman',
          'others': 'Test Others',
          'topic': 'Test Topic',
          'id': '1',
          'title': 'Morning Briefing',
          'description': 'Daily updates',
        },
      ],
    };
  }

  @override
  Future<Map<String, dynamic>> fetchReportData(
    String date,
    String userId,
  ) async {
    if (!shouldSucceed) throw Exception('Failed to fetch report data');
    if (!hasData) return {'status': 'success', 'data': []};

    return {
      'status': 'success',
      'data': [
        {
          'userId': '1',
          'userName': 'Test User',
          'area': 'Test Area',
          'pic': 'Test PIC',
          'payment': 1000,
          'salesmen': 5,
          'stu': 10,
          'leasing': 2,
          'id': '1',
          'title': 'Daily Report',
          'content': 'Daily activities',
        },
      ],
    };
  }
}
