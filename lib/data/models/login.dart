class LoginModel {
  final String id;
  final String name;
  final String memo;
  final String branch;
  final String shop;
  final List data;

  LoginModel({
    required this.id,
    required this.name,
    required this.memo,
    required this.branch,
    required this.shop,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['CustomerID'] as String,
      name: json['CName'] as String,
      memo: json['Memo'] as String,
      branch: json['BBranch'] as String,
      shop: json['BShop'] as String,
      data: json['DataDT'] as List,
    );
  }
}
