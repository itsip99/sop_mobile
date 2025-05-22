class SalesModel {
  final String tierLevel;
  final String userId;
  final String id;
  final String userName;

  SalesModel({
    required this.tierLevel,
    required this.userId,
    required this.id,
    required this.userName,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
      tierLevel: json['EntryLevelName'],
      userId: json['CustomerID'],
      id: json['KTPSalesman'],
      userName: json['SName'],
    );
  }
}
