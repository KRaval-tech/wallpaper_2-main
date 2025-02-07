import 'package:equatable/equatable.dart';

abstract class CategoryDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryDetailLoading extends CategoryDetailState {}

class CategoryDetailLoaded extends CategoryDetailState {
  final List<dynamic> wallpapers; // Now handles dynamic API data

  CategoryDetailLoaded(this.wallpapers);

  @override
  List<Object?> get props => [wallpapers];
}

class CategoryDetailError extends CategoryDetailState {
  final String message;

  CategoryDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
