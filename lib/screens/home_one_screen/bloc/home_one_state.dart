part of 'home_one_bloc.dart';

class HomeOneState {
  final List<dynamic> featuredWallpapers;
  final List<dynamic> suggestedWallpapers;
  final bool isLoading;
  final String? errorMessage;

  HomeOneState({
     this.featuredWallpapers = const[],
     this.suggestedWallpapers = const[],
    this.isLoading = false,
    this.errorMessage,
  });

  HomeOneState copyWith({
    List<dynamic>? featuredWallpapers,
    List<dynamic>? suggestedWallpapers,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeOneState(
      featuredWallpapers: featuredWallpapers ?? this.featuredWallpapers,
      suggestedWallpapers: suggestedWallpapers ?? this.suggestedWallpapers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
