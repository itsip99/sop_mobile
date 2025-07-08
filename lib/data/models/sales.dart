class SalesModel {
  final String tierLevel;
  final int isActive;
  final String userId;
  final String id;
  final String userName;

  SalesModel({
    required this.tierLevel,
    required this.isActive,
    required this.userId,
    required this.id,
    required this.userName,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) {
    return SalesModel(
      tierLevel: json['EntryLevel'],
      isActive: json['Active'],
      userId: json['CustomerID'],
      id: json['KTP'],
      userName: json['SName'],
    );
  }
}
