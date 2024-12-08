abstract class MapTabSideEffect {
  const MapTabSideEffect();
}

class ErrorSideEffect extends MapTabSideEffect {
  ErrorSideEffect(this.message);

  final String message;
}

class ShouldRequestUpdateSideEffect extends MapTabSideEffect {
  const ShouldRequestUpdateSideEffect();
}
