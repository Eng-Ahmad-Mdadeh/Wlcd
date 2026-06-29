import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/forum/forum_cubit.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum/forum_shared_widgets.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ForumQuestionForm extends StatefulWidget {
  const ForumQuestionForm({super.key});

  @override
  State<ForumQuestionForm> createState() => _ForumQuestionFormState();
}

class _ForumQuestionFormState extends State<ForumQuestionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ForumEditorScaffold(
      title: 'Title or summary',
      titleController: _titleController,
      detailsLabel: 'تفاصيل',
      detailsController: _detailsController,
      detailsHint: 'اكتب تفاصيل السؤال هنا',
      onPublish: () {
        final isPublished = context.read<ForumCubit>().publishQuestion(
              title: _titleController.text,
              details: _detailsController.text,
            );
        if (!isPublished) _showMessage(context, 'اكتب عنوان السؤال والتفاصيل أولاً');
      },
    );
  }
}

class ForumReplyForm extends StatefulWidget {
  const ForumReplyForm({super.key, required this.question});

  final ForumQuestion? question;

  @override
  State<ForumReplyForm> createState() => _ForumReplyFormState();
}

class _ForumReplyFormState extends State<ForumReplyForm> {
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ForumEditorScaffold(
      title: 'رد',
      detailsLabel: widget.question?.title ?? 'رد',
      detailsController: _replyController,
      detailsHint: 'اكتب ردك هنا',
      onPublish: () {
        final isPublished = context.read<ForumCubit>().publishReply(_replyController.text);
        if (!isPublished) _showMessage(context, 'اكتب الرد أولاً');
      },
    );
  }
}

class ForumEditorScaffold extends StatelessWidget {
  const ForumEditorScaffold({
    super.key,
    required this.title,
    this.titleController,
    required this.detailsLabel,
    required this.detailsController,
    required this.detailsHint,
    required this.onPublish,
  });

  final String title;
  final TextEditingController? titleController;
  final String detailsLabel;
  final TextEditingController detailsController;
  final String detailsHint;
  final VoidCallback onPublish;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      children: [
        SectionTitle(text: title, fontSize: 18, color: AppColors.searchCardTitle, fontWeight: FontWeight.w700),
        if (titleController != null) ...[
          SizedBox(height: AppHeight.h12),
          TextField(controller: titleController, decoration: _inputDecoration('طلب إعادة شرح')),
          SizedBox(height: AppHeight.h24),
        ] else
          SizedBox(height: AppHeight.h12),
        SectionTitle(text: detailsLabel, fontSize: 16, color: AppColors.searchCardTitle, fontWeight: FontWeight.w600),
        SizedBox(height: AppHeight.h10),
        _RichTextLikeField(controller: detailsController, hint: detailsHint),
        SizedBox(height: AppHeight.h24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ForumGradientButton(label: 'نشر', onPressed: onPublish),
            SizedBox(width: AppWidth.w12),
            ForumGradientButton(label: 'خلف', icon: Icons.arrow_back_rounded, onPressed: context.read<ForumCubit>().showList),
          ],
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.r12)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.r12), borderSide: const BorderSide(color: AppColors.searchCardBorder)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.r12), borderSide: const BorderSide(color: AppColors.primary)),
    );
  }
}

class _RichTextLikeField extends StatelessWidget {
  const _RichTextLikeField({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(border: Border.all(color: AppColors.searchCardBorder), color: AppColors.white),
      child: Column(
        children: [
          Container(
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p10),
            alignment: Alignment.centerRight,
            child: const Row(
              children: [
                Icon(Icons.format_color_text_rounded, size: 20),
                SizedBox(width: 12),
                Icon(Icons.format_bold_rounded, size: 20),
                SizedBox(width: 12),
                Icon(Icons.format_italic_rounded, size: 20),
                SizedBox(width: 12),
                Icon(Icons.format_underlined_rounded, size: 20),
                SizedBox(width: 12),
                Icon(Icons.format_list_bulleted_rounded, size: 20),
                SizedBox(width: 12),
                Icon(Icons.link_rounded, size: 20),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.searchCardBorder),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(hintText: hint, border: InputBorder.none, contentPadding: EdgeInsets.all(AppPaddingWidth.p12)),
            ),
          ),
        ],
      ),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
