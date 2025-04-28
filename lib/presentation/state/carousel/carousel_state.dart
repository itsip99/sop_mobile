class CarouselState {
  final int currentIndex;

  const CarouselState({
    this.currentIndex = 0,
  });

  factory CarouselState.initial() {
    return const CarouselState(currentIndex: 0);
  }

  CarouselState setNewIndex({int? currentIndex}) {
    return CarouselState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
