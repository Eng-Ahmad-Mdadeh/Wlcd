part of 'forum_cubit.dart';

enum ForumMode { list, ask, reply }

class ForumState {
  const ForumState({
    this.questions = const [],
    this.searchQuery = '',
    this.mode = ForumMode.list,
    this.selectedQuestionId,
  });

  final List<ForumQuestion> questions;
  final String searchQuery;
  final ForumMode mode;
  final String? selectedQuestionId;

  List<ForumQuestion> get filteredQuestions {
    final normalizedQuery = searchQuery.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return questions;

    return questions.where((question) {
      return question.title.toLowerCase().contains(normalizedQuery) ||
          question.details.toLowerCase().contains(normalizedQuery) ||
          question.replies.any((reply) => reply.message.toLowerCase().contains(normalizedQuery));
    }).toList();
  }

  ForumQuestion? get selectedQuestion {
    for (final question in questions) {
      if (question.id == selectedQuestionId) return question;
    }
    return null;
  }

  ForumState copyWith({
    List<ForumQuestion>? questions,
    String? searchQuery,
    ForumMode? mode,
    String? selectedQuestionId,
    bool clearSelectedQuestionId = false,
  }) {
    return ForumState(
      questions: questions ?? this.questions,
      searchQuery: searchQuery ?? this.searchQuery,
      mode: mode ?? this.mode,
      selectedQuestionId: clearSelectedQuestionId ? null : selectedQuestionId ?? this.selectedQuestionId,
    );
  }
}

class ForumQuestion {
  const ForumQuestion({
    required this.id,
    required this.title,
    required this.details,
    required this.createdAt,
    this.replies = const [],
    this.isLiked = false,
    this.isDisliked = false,
  });

  final String id;
  final String title;
  final String details;
  final DateTime createdAt;
  final List<ForumReply> replies;
  final bool isLiked;
  final bool isDisliked;

  ForumQuestion copyWith({
    String? title,
    String? details,
    DateTime? createdAt,
    List<ForumReply>? replies,
    bool? isLiked,
    bool? isDisliked,
  }) {
    return ForumQuestion(
      id: id,
      title: title ?? this.title,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
      replies: replies ?? this.replies,
      isLiked: isLiked ?? this.isLiked,
      isDisliked: isDisliked ?? this.isDisliked,
    );
  }
}

class ForumReply {
  const ForumReply({required this.id, required this.message, required this.createdAt});

  final String id;
  final String message;
  final DateTime createdAt;
}
