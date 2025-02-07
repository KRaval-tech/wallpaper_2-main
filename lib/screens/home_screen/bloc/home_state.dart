part of 'home_bloc.dart';

class HomeState extends Equatable {
  final HomeModel? homeModelObj;

  HomeState({this.homeModelObj});

  @override
  List<Object?> get props => [homeModelObj];

  HomeState copyWith({HomeModel? homeModelObj}) {
    return HomeState(
      homeModelObj: homeModelObj ?? this.homeModelObj,
    );
  }
}
