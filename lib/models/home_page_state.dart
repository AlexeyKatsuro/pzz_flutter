import 'package:pzz/utils/ui_message.dart';

class HomePageState {
  HomePageState({
    required this.isLoading,
    required this.errorMessage,
  });

  const HomePageState.initial({
    this.isLoading = false,
    this.errorMessage,
  });

  final bool isLoading;
  final UiMessage? errorMessage;

  HomePageState copyWith({
    bool? isLoading,
    UiMessage? errorMessage,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  HomePageState copyWithError({
    UiMessage? errorMessage,
  }) {
    return HomePageState(isLoading: isLoading, errorMessage: errorMessage);
  }
}
