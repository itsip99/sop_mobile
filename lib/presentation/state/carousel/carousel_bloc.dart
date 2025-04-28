import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_event.dart';
import 'package:sop_mobile/presentation/state/carousel/carousel_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc() : super(CarouselState.initial()) {
    on<CarouselEvent>((event, emit) {
      emit(state.setNewIndex(currentIndex: event.newIndex));
    });
  }
}
