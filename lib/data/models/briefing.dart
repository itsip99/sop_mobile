class BriefingModel {
  final String date;
  final String location;
  final int participants;
  final int shopManager;
  final int salesCounter;
  final int salesman;
  final int others;
  final String topic;
  final String pic;
  final String picThumb;

  BriefingModel({
    required this.date,
    required this.location,
    required this.participants,
    required this.shopManager,
    required this.salesCounter,
    required this.salesman,
    required this.others,
    required this.topic,
    required this.pic,
    required this.picThumb,
  });

  factory BriefingModel.fromJson(Map<String, dynamic> json) {
    return BriefingModel(
      date: json['TransDate'] as String,
      location: json['Lokasi'] as String,
      participants: json['Peserta'] as int,
      shopManager: json['SM'] as int,
      salesCounter: json['SC'] as int,
      salesman: json['Salesman'] as int,
      others: json['Other'] as int,
      topic: json['Topic'] as String,
      pic: json['Pic1'] as String,
      picThumb: json['PicThumb'] as String,
    );
  }
}
