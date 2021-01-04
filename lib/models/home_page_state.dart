import 'package:flutter/cupertino.dart';
import 'package:pzz/utils/UiMessage.dart';

class HomePageState {
  final bool isLoading;
  final UiMessage errorMessage;

  HomePageState({
    @required this.isLoading,
    @required this.errorMessage,
  });

  const HomePageState.initial({
    this.isLoading = false,
    this.errorMessage,
  });

  HomePageState copyWith({
    bool isLoading,
    UiMessage errorMessage,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  HomePageState copyWithError({
    UiMessage errorMessage,
  }) {
    return HomePageState(isLoading: this.isLoading, errorMessage: errorMessage);
  }
}
