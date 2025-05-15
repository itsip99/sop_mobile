import 'package:equatable/equatable.dart';
import 'package:sop_mobile/presentation/state/base_event.dart';

abstract class BriefEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class BriefCreation extends BriefEvent {
  final String username;
  final String branch;
  final String shop;
  final String date;
  final String location;
  final int participants;
  final int manager;
  final int counter;
  final int sales;
  final int other;
  final String desc;
  final String img;

  BriefCreation(
    this.username,
    this.branch,
    this.shop,
    this.date,
    this.location,
    this.participants,
    this.manager,
    this.counter,
    this.sales,
    this.other,
    this.desc,
    this.img,
  );
}
