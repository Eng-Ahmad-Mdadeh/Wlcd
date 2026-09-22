import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_search.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key, this.onSubmitted, this.onClose});

  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomSearch(
            color: AppColors.searchColor,
            prefixIconColor: AppColors.searchIcon,
            hintColor: AppColors.searchHeaderText,
            borderRadius: AppRadius.r12,
            onFieldSubmitted: onSubmitted,
          ),
        ),
        SizedBox(width: AppWidth.w12),
        IconButton(
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          onPressed: onClose,
          icon: const Icon(
            Icons.close,
            size: 24,
            color: AppColors.searchCloseIcon,
          ),
        ),
      ],
    );
  }
}
