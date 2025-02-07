part of 'pricing_bloc.dart';

abstract class PricingEvent {}

class FetchPricingEvent extends PricingEvent {
  final List<String> skus;

  FetchPricingEvent(this.skus);
}
