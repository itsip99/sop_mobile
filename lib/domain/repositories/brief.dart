abstract class BriefRepo {
  Future<Map<String, dynamic>> createBriefingReport(
    String username,
    String branch,
    String shop,
    String date,
    String location,
    int participants,
    int manager,
    int counter,
    int sales,
    int other,
    String desc,
    String img,
  );
}
