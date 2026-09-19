part of 'get_checkout_quote_bloc.dart';

sealed class IGetCheckoutQuoteState extends Equatable {
  const IGetCheckoutQuoteState();
}

final class GetCheckoutQuoteInitial extends IGetCheckoutQuoteState {
  const GetCheckoutQuoteInitial();
  @override
  List<Object?> get props => const [];
}

final class GetCheckoutQuoteLoading extends IGetCheckoutQuoteState {
  const GetCheckoutQuoteLoading();
  @override
  List<Object?> get props => const [];
}

final class GetCheckoutQuoteLoaded extends IGetCheckoutQuoteState {
  const GetCheckoutQuoteLoaded(this.getCheckoutQuote);

  final ContractJsonModel? getCheckoutQuote;

  @override
  List<Object?> get props => [getCheckoutQuote];
}

final class GetCheckoutQuoteFailed extends IGetCheckoutQuoteState {
  const GetCheckoutQuoteFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
