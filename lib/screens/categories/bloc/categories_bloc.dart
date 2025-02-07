import 'package:flutter_bloc/flutter_bloc.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<FetchCategories>((event, emit) async {
      emit(CategoriesLoading());
      try {
        // Mocked categories
        final categories = [
          Category(name: 'Iphone', image: 'assets/images2/iphone.png'),
          Category(name: 'Animals', image: 'assets/images2/animals.png'),
          Category(name: 'Cars', image: 'assets/images2/cars.png'),
          Category(name: 'Color', image: 'assets/images2/color.png'),
          Category(name: 'Cool', image: 'assets/images2/cool.png'),
          Category(name: 'Cute', image: 'assets/images2/cute.png'),
          Category(name: 'Design', image: 'assets/images2/design.png'),
          Category(name: 'Travel', image: 'assets/images2/travel.png'),
          Category(name: 'Art', image: 'assets/images2/art.png'),
          Category(name: 'Nature', image: 'assets/images2/nature.png'),
          Category(name: 'Sports', image: 'assets/images2/sports.png'),
          Category(name: 'Samsung', image: 'assets/images2/samsung.png'),
          // Add more categories here
        ];
        await Future.delayed(Duration(seconds: 1)); // Simulate loading
        emit(CategoriesLoaded(categories));
      } catch (e) {
        emit(CategoriesError('Failed to load categories'));
      }
    });
  }
}

class Category {
  final String name;
  final String image;

  Category({required this.name, required this.image});
}
