import 'package:wlcd/data/model/course_details/course_forum_tab/course_forum_tab_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/presentation/cubit/forum/forum_cubit.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum/forum_editor.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum/forum_list.dart';

class ForumTab extends StatelessWidget {
  const ForumTab({super.key, required this.forum});
  final CourseForumTabModel? forum;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForumCubit(
        questions: forum?.accessible == true
            ? [
                for (final thread in forum!.data)
                  ForumQuestion(
                    id: thread.forumThreadId,
                    title: thread.title,
                    details: '',
                    createdAt:
                        thread.createdAt ??
                        DateTime.fromMillisecondsSinceEpoch(0),
                  ),
              ]
            : const [],
      ),
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: _ForumTabBody(),
      ),
    );
  }
}

class _ForumTabBody extends StatelessWidget {
  const _ForumTabBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumCubit, ForumState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: switch (state.mode) {
            ForumMode.ask => const ForumQuestionForm(
              key: ValueKey('ask-question'),
            ),
            ForumMode.reply => ForumReplyForm(
              key: const ValueKey('reply-question'),
              question: state.selectedQuestion,
            ),
            ForumMode.list => ForumList(
              key: const ValueKey('forum-list'),
              state: state,
            ),
          },
        );
      },
    );
  }
}
