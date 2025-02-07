import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pricing_event.dart';
part 'pricing_state.dart';

class PricingBloc extends Bloc<PricingEvent, PricingState> {
  PricingBloc() : super(PricingInitial()) {
    on<FetchPricingEvent>(_onFetchPricing);
  }

  Future<void> _onFetchPricing(FetchPricingEvent event, Emitter<PricingState> emit) async {
    emit(PricingLoading());
    try {
      // Simulate fetching pricing details
      final prices = {
        "android.test.purchased": "\$4.99",
        "android.test.canceled": "\$36.99",
      };
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay
      emit(PricingLoaded(prices: prices));
    } catch (e) {
      emit(PricingError(message: "Failed to load pricing"));
    }
  }
}
