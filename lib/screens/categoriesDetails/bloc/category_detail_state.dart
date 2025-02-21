import 'package:equatable/equatable.dart';

abstract class CategoryDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryDetailLoading extends CategoryDetailState {}

class CategoryDetailLoaded extends CategoryDetailState {
  final List<dynamic> wallpapers; // Now handles dynamic API data
  final List<dynamic> wallpaper2; // Now handles dynamic API data

  CategoryDetailLoaded(this.wallpapers,this.wallpaper2);

  @override
  List<Object?> get props => [wallpapers,wallpaper2];
}

class CategoryDetailError extends CategoryDetailState {
  final String message;

  CategoryDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
