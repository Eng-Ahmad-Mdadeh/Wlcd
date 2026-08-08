part of 'request_phone_otp_bloc.dart';

sealed class IRequestPhoneOtpState extends Equatable {
  const IRequestPhoneOtpState();
}

final class RequestPhoneOtpInitial extends IRequestPhoneOtpState {
  @override
  List<Object?> get props => [];
}

final class RequestPhoneOtpLoading extends IRequestPhoneOtpState {
  @override
  List<Object?> get props => [];
}

final class RequestPhoneOtpLoaded extends IRequestPhoneOtpState {
  const RequestPhoneOtpLoaded({required this.challenge});

  final BaseModel<PhoneOtpChallengeModel>? challenge;

  @override
  List<Object?> get props => [challenge];
}

final class RequestPhoneOtpFailed extends IRequestPhoneOtpState {
  const RequestPhoneOtpFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
