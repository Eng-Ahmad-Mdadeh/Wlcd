import 'package:equatable/equatable.dart';

/// Contract-neutral response for email identifier operations.
///
/// The generated API contract is authoritative for the response schema. Until
/// it is available in this project, retaining the complete response avoids
/// inventing or discarding backend fields.
class EmailIdentifierModel extends Equatable {
  const EmailIdentifierModel({required this.data});

  final Map<String, dynamic> data;

  factory EmailIdentifierModel.fromJson(Map<String, dynamic> json) =>
      EmailIdentifierModel(data: Map.unmodifiable(json));

  @override
  List<Object?> get props => [data];
}
