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


import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_export.dart';
import 'category_detail_event.dart';
import 'category_detail_state.dart';


class CategoryDetailBloc extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  final ApiService apiService;

  CategoryDetailBloc(this.apiService) : super(CategoryDetailLoading()) {
    // Add an event handler for FetchCategoryWallpapers
    on<FetchCategoryWallpapers>(_onFetchCategoryWallpapers);
  }

  Future<void> _onFetchCategoryWallpapers(
      FetchCategoryWallpapers event, Emitter<CategoryDetailState> emit) async {
    emit(CategoryDetailLoading());
        try {
        // Fetch wallpapers from the API
        // final wallpapers = await apiService.fetchLatestWallpapers();
        // final wallpaper2 = await apiService.fetchRandomWallpapers();
          final wallpapers = await apiService.fetchFeaturedWallpapers();
          final wallpaper2 = await apiService.fetchSuggestedWallpapers();
        emit(CategoryDetailLoaded(wallpapers, wallpaper2));
        } catch (e) {
      emit(CategoryDetailError("Failed to load wallpapers: $e"));
    }
  }
}
