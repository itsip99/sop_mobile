import 'package:sop_mobile/presentation/state/base_event.dart';

class CarouselEvent extends BaseEvent {
  final int newIndex;

  CarouselEvent(this.newIndex);
}
