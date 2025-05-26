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
      tierLevel: json['EntryLevel'],
      userId: json['CustomerID'],
      id: json['KTP'],
      userName: json['SName'],
    );
  }
}
