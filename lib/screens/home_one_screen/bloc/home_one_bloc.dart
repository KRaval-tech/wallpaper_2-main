import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_2/core/api_service.dart';

part 'home_one_event.dart';
part 'home_one_state.dart';

class HomeOneBloc extends Bloc<HomeOneEvent, HomeOneState> {
  final ApiService apiService;
  HomeOneBloc(this.apiService) : super(HomeOneState(
    featuredWallpapers: [],
    suggestedWallpapers: [],
  )) {
    on<FetchWallpapersEvent>(_onFetchWallpapers);
  }

  Future<void> _onFetchWallpapers(
      FetchWallpapersEvent event,Emitter<HomeOneState> emit) async {
    try{
      emit(state.copyWith(isLoading:true));

      final featured = await apiService.fetchFeaturedWallpapers();
      final suggested = await apiService.fetchSuggestedWallpapers();

      emit(state.copyWith(
        featuredWallpapers: featured,
        suggestedWallpapers: suggested,
        isLoading: false,
      ));
    } catch(e){
      emit(state.copyWith(isLoading: false,errorMessage: e.toString()));
    }
  }

}
