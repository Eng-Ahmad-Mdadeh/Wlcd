part of 'get_checkout_quote_bloc.dart';

sealed class IGetCheckoutQuoteEvent extends Equatable {
  const IGetCheckoutQuoteEvent();
}

final class LoadGetCheckoutQuoteEvent extends IGetCheckoutQuoteEvent {
  const LoadGetCheckoutQuoteEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
