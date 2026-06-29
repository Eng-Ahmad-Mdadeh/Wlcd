import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/forum/forum_cubit.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum/forum_shared_widgets.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ForumQuestionCard extends StatelessWidget {
  const ForumQuestionCard({super.key, required this.question});

  final ForumQuestion question;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForumCubit>();

    return Container(
      margin: EdgeInsets.only(bottom: AppMarginHeight.m20),
      padding: EdgeInsets.all(AppPaddingWidth.p16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r18),
        border: Border.all(color: AppColors.searchCardBorder),
        boxShadow: [BoxShadow(color: AppColors.searchBottomShadow.withValues(alpha: .08), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ForumAuthorHeader(createdAt: question.createdAt),
          SizedBox(height: AppHeight.h18),
          SectionTitle(text: question.title, fontSize: 16, color: AppColors.searchCardTitle, fontWeight: FontWeight.w700, maxLines: 3),
          SizedBox(height: AppHeight.h10),
          BodyTitle(text: question.details, fontSize: 13, color: AppColors.searchRatingText, maxLines: 10, height: 1.5),
          SizedBox(height: AppHeight.h16),
          Row(
            children: [
              _RepliesCount(count: question.replies.length),
              const Spacer(),
              ForumOutlinedButton(label: 'رد على السؤال', icon: Icons.reply_rounded, onTap: () => cubit.showReplyForm(question.id)),
            ],
          ),
          if (question.replies.isNotEmpty) ...[
            Divider(height: AppHeight.h30, color: AppColors.searchCardBorder),
            ...question.replies.map((reply) => _ForumReplyTile(reply: reply)),
          ],
        ],
      ),
    );
  }
}

class _ForumAuthorHeader extends StatelessWidget {
  const _ForumAuthorHeader({required this.createdAt});

  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: AppColors.lightPrim,
            borderRadius: BorderRadius.circular(AppRadius.r14),
          ),
          child: const Icon(Icons.person_outline_rounded, color: AppColors.primary),
        ),
        SizedBox(width: AppWidth.w12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(text: 'ELIT IT', fontSize: 14, color: AppColors.searchCardTitle, fontWeight: FontWeight.w700),
              SizedBox(height: AppHeight.h4),
              Row(
                children: [
                  const Icon(Icons.access_time_rounded, size: 14, color: AppColors.searchRatingText),
                  SizedBox(width: AppWidth.w4),
                  BodyTitle(text: forumTimeAgo(createdAt), fontSize: 12, color: AppColors.searchRatingText),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p10, vertical: AppPaddingHeight.p6),
          decoration: BoxDecoration(
            color: AppColors.searchTagBackground,
            borderRadius: BorderRadius.circular(AppRadius.r50),
          ),
          child: const BodyTitle(text: 'سؤال', fontSize: 11, color: AppColors.searchTagText, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _RepliesCount extends StatelessWidget {
  const _RepliesCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p10, vertical: AppPaddingHeight.p7),
      decoration: BoxDecoration(
        color: AppColors.backGround,
        borderRadius: BorderRadius.circular(AppRadius.r12),
        border: Border.all(color: AppColors.searchCardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: AppColors.searchRatingText),
          SizedBox(width: AppWidth.w5),
          BodyTitle(text: '$count ردود', fontSize: 12, color: AppColors.searchRatingText, fontWeight: FontWeight.w600),
        ],
      ),
    );
  }
}

class _ForumReplyTile extends StatelessWidget {
  const _ForumReplyTile({required this.reply});

  final ForumReply reply;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: AppPaddingWidth.p18, bottom: AppPaddingHeight.p12),
      padding: EdgeInsets.all(AppPaddingWidth.p12),
      decoration: BoxDecoration(
        color: AppColors.backGround,
        borderRadius: BorderRadius.circular(AppRadius.r14),
        border: Border.all(color: AppColors.searchCardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(AppRadius.r10)),
            child: const Icon(Icons.person_outline_rounded, size: 18, color: AppColors.searchRatingText),
          ),
          SizedBox(width: AppWidth.w10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(child: SectionTitle(text: 'ELIT IT', fontSize: 13, color: AppColors.searchCardTitle, fontWeight: FontWeight.w700)),
                    BodyTitle(text: forumTimeAgo(reply.createdAt), fontSize: 11, color: AppColors.searchRatingText),
                  ],
                ),
                SizedBox(height: AppHeight.h8),
                BodyTitle(text: reply.message, fontSize: 13, color: AppColors.searchCardTitle, maxLines: 8, height: 1.45),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
