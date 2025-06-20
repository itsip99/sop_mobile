class LoginModel {
  final String branch;
  final String branchName;
  final String shop;
  final String id;
  final String name;
  final String memo;
  final List data;

  LoginModel({
    required this.branch,
    required this.branchName,
    required this.shop,
    required this.id,
    required this.name,
    required this.memo,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      branch: json['BBranch'] as String,
      branchName: json['BName'] as String,
      shop: json['BShop'] as String,
      id: json['CustomerID'] as String,
      name: json['CName'] as String,
      memo: json['Memo'] as String,
      data: json['DataDT'] as List,
    );
  }
}
