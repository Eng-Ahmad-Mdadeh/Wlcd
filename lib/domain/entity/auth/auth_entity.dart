import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AuthEntity extends Equatable {
  final String? phone;
  final String? typeMessage;
  final String? code;
  final String? fcm;
  final bool? rememberMe;

  const AuthEntity({
    this.phone,
    this.typeMessage,
    this.code,
    this.fcm,
    this.rememberMe,
  });

  Map<String, dynamic> toJson() {
    return {
      if (phone != null) 'phone': phone,
      // if (phone != null) 'phone': "+966550610408",
      // if (phone != null) 'phone': "+9660581333357",
      // if (typeMessage != null) 'type_message': 'sms',
      if (typeMessage != null) 'type_message': typeMessage,
      if (code != null) 'code': code,
      // if (code != null) 'code': "4441",
      if (fcm != null) 'fcm_token': fcm,
    };
  }

  @override
  List<Object?> get props => [
    phone,
    typeMessage,
    code,
    fcm,
    rememberMe,
  ];
}
