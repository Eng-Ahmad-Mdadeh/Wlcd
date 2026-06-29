import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/forum/forum_cubit.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum/forum_question_card.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum/forum_shared_widgets.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ForumList extends StatefulWidget {
  const ForumList({super.key, required this.state});

  final ForumState state;

  @override
  State<ForumList> createState() => _ForumListState();
}

class _ForumListState extends State<ForumList> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void didUpdateWidget(covariant ForumList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_searchController.text != widget.state.searchQuery) {
      _searchController.text = widget.state.searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForumCubit>();

    return ListView(
      key: const PageStorageKey('forum-tab-scroll'),
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      children: [
        _ForumIntroCard(questionsCount: widget.state.questions.length),
        SizedBox(height: AppHeight.h16),
        _ForumSearchField(controller: _searchController, onChanged: cubit.updateSearchQuery),
        SizedBox(height: AppHeight.h24),
        Row(
          children: [
            Expanded(
              child: SectionTitle(
                text: 'أسئلة في هذه الدورة ${widget.state.questions.length}',
                fontSize: 20,
                color: AppColors.searchCardTitle,
                fontWeight: FontWeight.w700,
              ),
            ),
            ForumGradientButton(label: 'اطرح سؤال', icon: Icons.add_rounded, onPressed: cubit.showQuestionForm),
          ],
        ),
        SizedBox(height: AppHeight.h20),
        if (widget.state.filteredQuestions.isEmpty)
          const _EmptyForum()
        else
          ...widget.state.filteredQuestions.map((question) => ForumQuestionCard(question: question)),
      ],
    );
  }
}


class _ForumIntroCard extends StatelessWidget {
  const _ForumIntroCard({required this.questionsCount});

  final int questionsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddingWidth.p16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent]),
        borderRadius: BorderRadius.circular(AppRadius.r18),
        boxShadow: [BoxShadow(color: AppColors.searchBottomShadow, blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(color: AppColors.white.withValues(alpha: .18), borderRadius: BorderRadius.circular(AppRadius.r14)),
            child: const Icon(Icons.forum_outlined, color: AppColors.white),
          ),
          SizedBox(width: AppWidth.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(text: 'منتدى الدورة', fontSize: 17, color: AppColors.white, fontWeight: FontWeight.w700),
                SizedBox(height: AppHeight.h6),
                BodyTitle(
                  text: 'اطرح سؤالك وتابع ردود المعلم والطلاب في مكان واحد.',
                  fontSize: 12,
                  color: AppColors.white.withValues(alpha: .86),
                  maxLines: 2,
                  height: 1.4,
                ),
              ],
            ),
          ),
          SizedBox(width: AppWidth.w8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p10, vertical: AppPaddingHeight.p8),
            decoration: BoxDecoration(color: AppColors.white.withValues(alpha: .16), borderRadius: BorderRadius.circular(AppRadius.r12)),
            child: BodyTitle(text: '$questionsCount أسئلة', fontSize: 12, color: AppColors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _ForumSearchField extends StatelessWidget {
  const _ForumSearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'البحث عن الإجابات هنا',
        suffixIcon: const Icon(Icons.search_rounded, color: AppColors.searchRatingText),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.r14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r14),
          borderSide: const BorderSide(color: AppColors.searchCardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r14),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}

class _EmptyForum extends StatelessWidget {
  const _EmptyForum();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p45, horizontal: AppPaddingWidth.p18),
      decoration: BoxDecoration(
        color: AppColors.backGround,
        borderRadius: BorderRadius.circular(AppRadius.r16),
        border: Border.all(color: AppColors.searchCardBorder),
      ),
      child: const Column(
        children: [
          Icon(Icons.forum_outlined, size: 42, color: AppColors.searchRatingText),
          SizedBox(height: 12),
          SectionTitle(text: 'لا توجد أسئلة بعد', fontSize: 16, color: AppColors.searchCardTitle),
          SizedBox(height: 6),
          BodyTitle(text: 'ابدأ النقاش بطرح أول سؤال في المنتدى.', fontSize: 13, color: AppColors.searchRatingText),
        ],
      ),
    );
  }
}
