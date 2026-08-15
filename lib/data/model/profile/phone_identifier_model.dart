import 'package:equatable/equatable.dart';

/// Contract-neutral response for phone identifier operations.
///
/// The generated API contract is authoritative for the response schema. Until
/// it is available in this project, retaining the complete response avoids
/// inventing or discarding backend fields.
class PhoneIdentifierModel extends Equatable {
  const PhoneIdentifierModel({required this.data});

  final Map<String, dynamic> data;

  factory PhoneIdentifierModel.fromJson(Map<String, dynamic> json) =>
      PhoneIdentifierModel(data: Map.unmodifiable(json));

  @override
  List<Object?> get props => [data];
}
