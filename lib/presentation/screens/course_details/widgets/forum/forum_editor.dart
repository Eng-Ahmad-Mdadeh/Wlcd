import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/forum/forum_cubit.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum/forum_shared_widgets.dart';
import 'package:wlcd/presentation/widgets/custom_html_editor.dart';
import 'package:wlcd/presentation/widgets/custom_text_from_field.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ForumQuestionForm extends StatefulWidget {
  const ForumQuestionForm({super.key});

  @override
  State<ForumQuestionForm> createState() => _ForumQuestionFormState();
}

class _ForumQuestionFormState extends State<ForumQuestionForm> {
  final TextEditingController _titleController = TextEditingController();
  final QuillController quillController = QuillController.basic();

  @override
  void dispose() {
    _titleController.dispose();
    quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ForumEditorScaffold(
      title: 'العنوان',
      titleController: _titleController,
      detailsLabel: 'تفاصيل',
      quillController: quillController,
      detailsHint: 'اكتب تفاصيل السؤال هنا',
      onPublish: () {
        final isPublished = context.read<ForumCubit>().publishQuestion(
          title: _titleController.text,
          details: quillController.document.toPlainText(),
        );
        if (!isPublished) {
          _showMessage(context, 'اكتب عنوان السؤال والتفاصيل أولاً');
        }
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
  final QuillController _replyController = QuillController.basic();

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
      quillController: _replyController,
      detailsHint: 'اكتب ردك هنا',
      onPublish: () {
        final isPublished = context.read<ForumCubit>().publishReply(
          _replyController.document.toPlainText(),
        );
        if (!isPublished) {
          _showMessage(context, 'اكتب الرد أولاً');
        }
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
    required this.quillController,
    required this.detailsHint,
    required this.onPublish,
  });

  final String title;
  final TextEditingController? titleController;
  final String detailsLabel;
  final QuillController quillController;
  final String detailsHint;
  final VoidCallback onPublish;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p18,
        0,
        AppPaddingWidth.p18,
        AppPaddingHeight.p90,
      ),
      children: [
        SectionTitle(text: title, color: AppColors.searchCardTitle),
        if (titleController != null) ...[
          SizedBox(height: AppHeight.h5),
          CustomTextFromField(
            controller: titleController,
            hintText: "الفقرة السابعة",
            filled: false,
            enableInputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r12),
              borderSide: const BorderSide(color: AppColors.searchCardBorder),
            ),
            focusedInputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.r12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
          SizedBox(height: AppHeight.h24),
        ] else
          SizedBox(height: AppHeight.h12),
        SectionTitle(text: detailsLabel, color: AppColors.searchCardTitle),
        SizedBox(height: AppHeight.h5),
        CustomHtmlEditor(quillController),
        SizedBox(height: AppHeight.h24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ForumGradientButton(label: 'نشر', onPressed: onPublish),
            SizedBox(width: AppWidth.w12),
            ForumGradientButton(
              label: 'رجوع',
              icon: Icons.arrow_back_rounded,
              onPressed: context.read<ForumCubit>().showList,
            ),
          ],
        ),
      ],
    );
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
