import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/domain/repositories/sales.dart';

class FakeSalesRepo implements SalesRepo {
  final bool shouldFail;
  
  FakeSalesRepo({this.shouldFail = false});

  @override
  Future<Map<String, dynamic>> fetchSalesman(String username) async {
    if (shouldFail) {
      throw Exception('Failed to fetch salesman data');
    }
    
    final salesList = [
      SalesModel(
        id: '1',
        userName: 'John Doe',
        tierLevel: 'Gold',
        userId: 'user1',
      ),
      SalesModel(
        id: '2',
        userName: 'Jane Smith',
        tierLevel: 'Silver',
        userId: 'user2',
      ),
    ];
    
    return {
      'status': 'success',
      'data': salesList,
    };
  }

  @override
  Future<Map<String, dynamic>> addSalesman(
    String userId,
    String id,
    String name,
    String tier,
  ) async {
    if (shouldFail) {
      throw Exception('Failed to add salesman');
    }
    
    return {
      'status': 'success',
      'data': 'Salesman added successfully',
    };
  }
}
