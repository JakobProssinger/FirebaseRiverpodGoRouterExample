class AuthLoadingState {
  const AuthLoadingState(this.state, this.error);
  final LoadingStateEnum state;
  final Exception? error;

  bool get isLoading => state == LoadingStateEnum.loading;

  bool get hasError => state == LoadingStateEnum.error;
}

enum LoadingStateEnum {
  initial,
  loading,
  success,
  error,
}
