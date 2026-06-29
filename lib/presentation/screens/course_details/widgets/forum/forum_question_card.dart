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
        borderRadius: BorderRadius.circular(AppRadius.r16),
        border: Border.all(color: AppColors.searchCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.lightGrey,
                child: Icon(Icons.image_outlined, color: AppColors.searchImageIcon),
              ),
              SizedBox(width: AppWidth.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(text: 'ELIT IT', fontSize: 14, color: AppColors.searchCardTitle, fontWeight: FontWeight.w700),
                    BodyTitle(text: forumTimeAgo(question.createdAt), fontSize: 12, color: AppColors.searchRatingText),
                  ],
                ),
              ),
              const Icon(Icons.more_vert_rounded, color: AppColors.black),
            ],
          ),
          SizedBox(height: AppHeight.h18),
          SectionTitle(text: question.title, fontSize: 15, color: AppColors.searchCardTitle, fontWeight: FontWeight.w600),
          SizedBox(height: AppHeight.h10),
          BodyTitle(text: question.details, fontSize: 13, color: AppColors.searchRatingText, maxLines: 10),
          SizedBox(height: AppHeight.h18),
          Wrap(
            spacing: AppWidth.w14,
            runSpacing: AppHeight.h8,
            children: [
              ForumActionButton(
                icon: question.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                label: 'أعجبني',
                onTap: () => cubit.toggleLike(question.id),
              ),
              ForumActionButton(
                icon: question.isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
                label: 'لا يعجبني',
                onTap: () => cubit.toggleDislike(question.id),
              ),
              ForumActionButton(icon: Icons.reply_rounded, label: 'رد', onTap: () => cubit.showReplyForm(question.id)),
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

class _ForumReplyTile extends StatelessWidget {
  const _ForumReplyTile({required this.reply});

  final ForumReply reply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: AppPaddingWidth.p30, bottom: AppPaddingHeight.p12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 18, backgroundColor: AppColors.lightGrey, child: Icon(Icons.image_outlined, size: 18)),
          SizedBox(width: AppWidth.w10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(text: 'ELIT IT', fontSize: 13, color: AppColors.searchCardTitle, fontWeight: FontWeight.w700),
                SizedBox(height: AppHeight.h4),
                BodyTitle(text: forumTimeAgo(reply.createdAt), fontSize: 11, color: AppColors.searchRatingText),
                SizedBox(height: AppHeight.h6),
                BodyTitle(text: reply.message, fontSize: 13, color: AppColors.searchCardTitle, maxLines: 8),
              ],
            ),
          ),
          const Icon(Icons.edit_outlined, color: AppColors.grey, size: 18),
          SizedBox(width: AppWidth.w8),
          const Icon(Icons.delete_outline_rounded, color: AppColors.grey, size: 18),
        ],
      ),
    );
  }
}
