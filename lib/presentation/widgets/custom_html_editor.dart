import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class CustomHtmlEditor extends StatelessWidget {
  final QuillController _quillController;

  const CustomHtmlEditor(
    this._quillController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greySec),
        borderRadius: BorderRadius.circular(AppRadius.r7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Center(child: HtmlEditorToolbarWidget(_quillController)),
          const Divider(color: AppColors.greySec),
          HtmlEditorInputWidget(_quillController),
        ],
      ),
    );
  }
}

class HtmlEditorInputWidget extends StatelessWidget {
  final QuillController _quillController;

  const HtmlEditorInputWidget(this._quillController, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h200,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddingWidth.p13,
          vertical: AppPaddingHeight.p10,
        ),
        child: QuillEditor.basic(
          controller: _quillController,
        ),
      ),
    );
  }
}

class HtmlEditorToolbarWidget extends StatelessWidget {
  final QuillController _quillController;

  const HtmlEditorToolbarWidget(this._quillController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: AppHeight.h10,
      children: [
        HtmlEditorIconButton(
          icon: Icons.undo,
          onPressed: () {
            _quillController.undo();
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.redo,
          onPressed: () {
            _quillController.redo();
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_bold,
          onPressed: () {
            final isBold = _quillController.getSelectionStyle().attributes.containsKey(Attribute.bold.key);
            _quillController.formatSelection(isBold ? Attribute.clone(Attribute.bold, null) : Attribute.bold);
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_italic,
          onPressed: () {
            final isItalic = _quillController.getSelectionStyle().attributes.containsKey(Attribute.italic.key);
            _quillController.formatSelection(isItalic ? Attribute.clone(Attribute.italic, null) : Attribute.italic);
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_underlined,
          onPressed: () {
            final isUnderline = _quillController.getSelectionStyle().attributes.containsKey(Attribute.underline.key);
            _quillController.formatSelection(isUnderline ? Attribute.clone(Attribute.underline, null) : Attribute.underline);
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_align_right,
          onPressed: () {
            _quillController.formatSelection(Attribute.rightAlignment);
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_align_center,
          onPressed: () {
            _quillController.formatSelection(Attribute.centerAlignment);
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_align_left,
          onPressed: () {
            _quillController.formatSelection(Attribute.leftAlignment);
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_list_bulleted,
          onPressed: () {
            final isBullet = _quillController.getSelectionStyle().attributes.containsKey(Attribute.ul.key);
            _quillController.formatSelection(isBullet ? Attribute.clone(Attribute.ul, null) : Attribute.ul);
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_list_numbered,
          onPressed: () {
            final isOrdered = _quillController.getSelectionStyle().attributes.containsKey(Attribute.ol.key);
            _quillController.formatSelection(isOrdered ? Attribute.clone(Attribute.ol, null) : Attribute.ol);
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_color_text,
          onPressed: () async {
            final currentColor = _quillController.getSelectionStyle().attributes[Attribute.color.key]?.value;

            Color selectedColor = currentColor != null ? _fromHex(currentColor) : Colors.black;

            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.white,
                  title: BodyTitle(text: 'اختر لون النص'),
                  actionsPadding: EdgeInsetsDirectional.only(
                    start: AppPaddingWidth.p20,
                    end: AppPaddingWidth.p20,
                    bottom: AppPaddingHeight.p10,
                  ),
                  contentPadding: EdgeInsetsDirectional.only(
                    start: AppPaddingWidth.p20,
                    end: AppPaddingWidth.p20,
                    top: AppPaddingHeight.p20,
                  ),
                  content: BlockPicker(
                    pickerColor: selectedColor,
                    onColorChanged: (color) {
                      selectedColor = color;
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // تطبيق اللون المختار
                        final hexColor = '#${selectedColor.value.toRadixString(16).substring(2)}';
                        _quillController.formatSelection(Attribute(Attribute.color.key, AttributeScope.inline, hexColor));
                      },
                      child: const BodyTitle(text: 'تم'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // إزالة اللون
                        _quillController.formatSelection(Attribute.clone(Attribute.color, null));
                      },
                      child: BodyTitle(text: 'إزالة اللون'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_quote,
          onPressed: () {
            final attrs = _quillController.getSelectionStyle().attributes;
            final isQuote = attrs.containsKey(Attribute.blockQuote.key);

            if (isQuote) {
              // إزالة خاصية الاقتباس
              _quillController.formatSelection(Attribute.clone(Attribute.blockQuote, null));
            } else {
              // تفعيل خاصية الاقتباس
              _quillController.formatSelection(Attribute.blockQuote);
            }
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_size,
          onPressed: () {
            _quillController.formatSelection(Attribute.size);
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.title,
          onPressed: () {
            final attrs = _quillController.getSelectionStyle().attributes;
            final isHeader = attrs.containsKey(Attribute.h4.key);

            _quillController.formatSelection(
              isHeader ? Attribute.clone(Attribute.h4, null) : Attribute.h4,
            );
          },
        ),
//         HtmlEditorIconButton(
//           icon: Icons.payment, // أيقونة تمثل الدفع
//           onPressed: () {
//             const paymentPolicy = '''
// 💰 الدفع شهري مقدم
// 🚫 الإلغاء متاح قبل 7 أيام من تاريخ الدخول دون رسوم
// ''';
//
//             final index = _quillController.selection.baseOffset;
//             _quillController.replaceText(index, 0, paymentPolicy, null);
//           },
//         ),
//         HtmlEditorIconButton(
//           icon: Icons.rule, // أيقونة تمثل الشروط
//           onPressed: () {
//             const conditionsText = '''
// 🔹 يجب عدم التدخين داخل العقار
// 🔹 يمنع إدخال الحيوانات الأليفة
// 🔹 العقار مخصص للسكن العائلي فقط
// ''';
//
//             final index = _quillController.selection.baseOffset;
//             _quillController.replaceText(index, 0, conditionsText, null);
//           },
//         ),
        HtmlEditorIconButton(
          icon: Icons.warning_amber_outlined,
          onPressed: () {
            final index = _quillController.selection.baseOffset;
            final warningBlock = '⚠️  ';

            _quillController.replaceText(index, 0, warningBlock, null);
          },
        ),

        HtmlEditorIconButton(
          icon: Icons.check_box_outlined,
          onPressed: () {
            final index = _quillController.selection.baseOffset;
            _quillController.replaceText(index, 0, CustomBlockEmbed.checklistItem, null);
          },
        ),

        HtmlEditorIconButton(
          icon: Icons.horizontal_rule,
          onPressed: () {
            final index = _quillController.selection.baseOffset;
            _quillController.replaceText(
              index,
              0,
              CustomBlockEmbed.horizontalRule,
              null,
            );
          },
        ),
        HtmlEditorIconButton(
          icon: Icons.format_align_justify,
          onPressed: () {
            _quillController.formatSelection(Attribute.justifyAlignment);
          },
        ),
      ],
    );
  }

  Color _fromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // أضف الشفافية الافتراضية
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}

class HtmlEditorIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const HtmlEditorIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppPaddingWidth.p10,
        end: AppPaddingWidth.p10,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Icon(icon, size: AppSize.s20),
      ),
    );
  }
}

class CustomBlockEmbed {
  static BlockEmbed horizontalRule = const BlockEmbed('hr', '\n');
  static const BlockEmbed checklistItem = BlockEmbed('checked', '\n');
}
