enum PageAnimation { slide, fade, none }

enum UserType { male, female }

enum MediaModelType { user, Auction, WalletTopUpRequest, SingleAuction, ContactUs, PaymentTransaction }

enum MediaType { profile, attachments }

enum CategoryBanner { transport_services, home, medical_services, products }

enum AnimalType {
  horse,
  camel,
  non_breeding_female,
  breeding_female,
  male,
  castrated,
  foal_male,
  foal_female,
}

enum AdType { offer, auction, annual }

enum DocumentType {
  owner_document,
  info_certificate,
  medical_exam_certificate,
  normal,
}

enum TransportType { internal, external, internal_external, horse, camel }

enum PaymentMethodType {
  wallet,
  online_payment,
  apple_pay,
  none,
}

enum PaymentPurposeEnum {
  publish_offer,
  // sent_offer,
  publish_auction,
  wallet_top_up,
  pay_paddle_fee,
  publish_single_auction,
  pay_remaining_amount,
  buy_offer,
  refund_balance,
  none,
}

enum AuctionTypeInWallet { annual, normal, group, none }

enum PaymentTypeEnum { full, deposit, none }

enum ActorTypeEnum { seller, buyer }

enum AuctionTypeEnum { electronic, live, none }

enum AuctionStatus { pending, accepted, rejected, withdrawn, sold, unsold }

enum AuctionStats { upcoming, active, ended, live, closed }

enum TransactionPaymentMethod { wallet, bank_transfer, electronic, system }

enum AnnualAuctionStatus { live, upcoming, ended }

enum AvailabilityStatus { available_for_sellers, available_for_buyers }

enum AnnualPaddleOption { normal, premium, vip }


enum PregnancyStatus { vaccinated, unvaccinated, unsure }
