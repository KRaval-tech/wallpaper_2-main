import 'package:equatable/equatable.dart';

abstract class CategoryDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCategoryWallpapers extends CategoryDetailEvent {
  final String categoryId;

  FetchCategoryWallpapers(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
