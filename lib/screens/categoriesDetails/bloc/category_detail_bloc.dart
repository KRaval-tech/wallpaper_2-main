// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/api_service.dart';
// import 'category_detail_event.dart';
// import 'category_detail_state.dart';
//
//
// class CategoryDetailBloc extends Bloc<CategoryDetailEvent, CategoryDetailState> {
//   final ApiService apiService;
//
//   CategoryDetailBloc(this.apiService) : super(CategoryDetailLoading());
//
//   @override
//   Stream<CategoryDetailState> mapEventToState(CategoryDetailEvent event) async* {
//     if (event is FetchCategoryWallpapers) {
//       yield CategoryDetailLoading();
//       try {
//         // Fetch wallpapers from the API
//         final wallpapers = await apiService.fetchFeaturedWallpapers();
//         yield CategoryDetailLoaded(wallpapers);
//       } catch (e) {
//         yield CategoryDetailError("Failed to load wallpapers: $e");
//       }
//     }
//   }
// }


// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/app_export.dart';
// import 'category_detail_event.dart';
// import 'category_detail_state.dart';
//
//
// class CategoryDetailBloc extends Bloc<CategoryDetailEvent, CategoryDetailState> {
//   final ApiService apiService;
//
//   CategoryDetailBloc(this.apiService) : super(CategoryDetailLoading()) {
//     // Add an event handler for FetchCategoryWallpapers
//     on<FetchCategoryWallpapers>(_onFetchCategoryWallpapers);
//   }
//
//   Future<void> _onFetchCategoryWallpapers(
//       FetchCategoryWallpapers event, Emitter<CategoryDetailState> emit) async {
//     emit(CategoryDetailLoading());
//         try {
//         // Fetch wallpapers from the API
//         // final wallpapers = await apiService.fetchLatestWallpapers();
//         // final wallpaper2 = await apiService.fetchRandomWallpapers();
//           final wallpapers = await apiService.fetchFeaturedWallpapers();
//           final wallpaper2 = await apiService.fetchSuggestedWallpapers();
//         emit(CategoryDetailLoaded(wallpapers, wallpaper2));
//         } catch (e) {
//       emit(CategoryDetailError("Failed to load wallpapers: $e"));
//     }
//   }
// }



import 'package:flutter/foundation.dart'; // compute() ke liye
import 'package:rxdart/rxdart.dart';
import '../../../core/app_export.dart';
import 'category_detail_event.dart';
import 'category_detail_state.dart';

class CategoryDetailBloc extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  final ApiService apiService;

  CategoryDetailBloc(this.apiService) : super(CategoryDetailLoading()) {
    on<FetchCategoryWallpapers>(
      _onFetchCategoryWallpapers,
      transformer: debounceSequential(const Duration(milliseconds: 500)), // Debounce added
    );
  }

  Future<void> _onFetchCategoryWallpapers(
      FetchCategoryWallpapers event, Emitter<CategoryDetailState> emit) async {
    emit(CategoryDetailLoading());
    try {
      // Background thread pe API calls ke liye `compute()` use kiya hai
      final wallpapers = await compute(_fetchFeaturedWallpapers, apiService);
      final wallpaper2 = await compute(_fetchSuggestedWallpapers, apiService);

      emit(CategoryDetailLoaded(wallpapers, wallpaper2));
    } catch (e, stackTrace) {
      debugPrint("Error fetching wallpapers: $e\n$stackTrace"); // Proper error log
      emit(CategoryDetailError("Failed to load wallpapers: ${e.toString()}"));
    }
  }

  // Background thread pe API calls
  static Future<List<dynamic>> _fetchFeaturedWallpapers(ApiService api) async {
    return await api.fetchFeaturedWallpapers();
  }

  static Future<List<dynamic>> _fetchSuggestedWallpapers(ApiService api) async {
    return await api.fetchSuggestedWallpapers();
  }

  // Debounce function: Avoids multiple quick API calls
  static EventTransformer<E> debounceSequential<E>(Duration duration) {
    return (events, mapper) {
      return events.debounceTime(duration).asyncExpand(mapper);
    };
  }
}


