import 'package:flutter_bloc/flutter_bloc.dart';

part 'forum_state.dart';

class ForumCubit extends Cubit<ForumState> {
  ForumCubit() : super(const ForumState());

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void showQuestionForm() {
    emit(state.copyWith(mode: ForumMode.ask, clearSelectedQuestionId: true));
  }

  void showReplyForm(String questionId) {
    emit(state.copyWith(mode: ForumMode.reply, selectedQuestionId: questionId));
  }

  void showList() {
    emit(state.copyWith(mode: ForumMode.list, clearSelectedQuestionId: true));
  }

  bool publishQuestion({required String title, required String details}) {
    final normalizedTitle = title.trim();
    final normalizedDetails = details.trim();
    if (normalizedTitle.isEmpty || normalizedDetails.isEmpty) return false;

    final question = ForumQuestion(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: normalizedTitle,
      details: normalizedDetails,
      createdAt: DateTime.now(),
    );

    emit(
      state.copyWith(
        mode: ForumMode.list,
        questions: [question, ...state.questions],
        clearSelectedQuestionId: true,
      ),
    );
    return true;
  }

  bool publishReply(String message) {
    final selectedQuestionId = state.selectedQuestionId;
    final normalizedMessage = message.trim();
    if (selectedQuestionId == null || normalizedMessage.isEmpty) return false;

    final reply = ForumReply(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      message: normalizedMessage,
      createdAt: DateTime.now(),
    );

    final questions = state.questions.map((question) {
      if (question.id != selectedQuestionId) return question;
      return question.copyWith(replies: [...question.replies, reply]);
    }).toList();

    emit(
      state.copyWith(
        mode: ForumMode.list,
        questions: questions,
        clearSelectedQuestionId: true,
      ),
    );
    return true;
  }

  void toggleLike(String questionId) {
    final questions = state.questions.map((question) {
      if (question.id != questionId) return question;
      return question.copyWith(isLiked: !question.isLiked);
    }).toList();
    emit(state.copyWith(questions: questions));
  }

  void toggleDislike(String questionId) {
    final questions = state.questions.map((question) {
      if (question.id != questionId) return question;
      return question.copyWith(isDisliked: !question.isDisliked);
    }).toList();
    emit(state.copyWith(questions: questions));
  }
}
