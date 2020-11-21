import 'package:flutter/cupertino.dart';

class HomePageState {
  final bool isLoading;
  final String errorMessage;

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
    String errorMessage,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  HomePageState copyWithError({
    String errorMessage,
  }) {
    return HomePageState(isLoading: this.isLoading, errorMessage: errorMessage);
  }
}
