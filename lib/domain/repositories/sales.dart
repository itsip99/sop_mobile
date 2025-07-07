abstract class SalesRepo {
  Future<Map<String, dynamic>> fetchSalesman(String username);
  Future<Map<String, dynamic>> addSalesman(
    String userId,
    String id,
    String name,
    String tier,
    int status,
  );
}
