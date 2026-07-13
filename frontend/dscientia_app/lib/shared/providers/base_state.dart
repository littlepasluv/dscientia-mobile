import 'provider_states.dart';

class BaseState<T> {
  final ProviderStatus status;
  final T? data;
  final String? error;

  const BaseState({required this.status, this.data, this.error});

  const BaseState.initial()
    : status = ProviderStatus.initial,
      data = null,
      error = null;
}
