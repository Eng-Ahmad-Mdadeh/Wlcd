import 'package:equatable/equatable.dart';

class ListNotificationsEntity extends Equatable {
  const ListNotificationsEntity({
    this.cursor,
    this.limit = 20,
    this.category,
    this.readState,
  });

  final String? cursor;
  final int limit;
  final String? category;
  final String? readState;

  ListNotificationsEntity copyWith({
    String? cursor,
    int? limit,
    String? category,
    String? readState,
    bool clearCursor = false,
    bool clearCategory = false,
    bool clearReadState = false,
  }) => ListNotificationsEntity(
    cursor: clearCursor ? null : cursor ?? this.cursor,
    limit: limit ?? this.limit,
    category: clearCategory ? null : category ?? this.category,
    readState: clearReadState ? null : readState ?? this.readState,
  );

  Map<String, dynamic> toQueryParameters() => {
    if (cursor != null) 'cursor': cursor,
    'limit': limit,
    if (category != null) 'category': category,
    if (readState != null) 'readState': readState,
  };

  @override
  List<Object?> get props => [cursor, limit, category, readState];
}
