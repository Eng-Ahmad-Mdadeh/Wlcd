import 'package:equatable/equatable.dart';

/// Preserves the unread-count projection without guessing fields that are not
/// documented by the Flutter handoff. Consumers can read the generated
/// contract value from [data].
class UnreadNotificationCountModel extends Equatable {
  const UnreadNotificationCountModel(this.data);

  final Map<String, dynamic> data;

  factory UnreadNotificationCountModel.fromJson(Map<String, dynamic> json) =>
      UnreadNotificationCountModel(Map<String, dynamic>.unmodifiable(json));

  @override
  List<Object?> get props => [data];
}
