import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/presentation/cubit/forum/forum_cubit.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum/forum_editor.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum/forum_list.dart';

class ForumTab extends StatelessWidget {
  const ForumTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForumCubit(),
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
            ForumMode.ask => const ForumQuestionForm(key: ValueKey('ask-question')),
            ForumMode.reply => ForumReplyForm(key: const ValueKey('reply-question'), question: state.selectedQuestion),
            ForumMode.list => ForumList(key: const ValueKey('forum-list'), state: state),
          },
        );
      },
    );
  }
}
