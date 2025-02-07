part of 'pricing_bloc.dart';

// pricing_state.dart
abstract class PricingState {}

class PricingInitial extends PricingState {}

class PricingLoading extends PricingState {}

class PricingLoaded extends PricingState {
  final Map<String, String> prices;

  //PricingLoaded(this.prices);
  PricingLoaded({required this.prices});
}

class PricingError extends PricingState {
  final String message;

  //PricingError(this.message);
  PricingError({required this.message});
}