import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/helper/launch_url_helper.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/domain/entity/catalog/global_platform/global_platform_entity.dart';
import 'package:wlcd/presentation/bloc/catalog/global_platforms/global_platforms_bloc.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ExternalCoursesSection extends StatelessWidget {
  const ExternalCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalPlatformsBloc, IGlobalPlatformsState>(
      builder: (context, state) {
        if (state is GlobalPlatformsFailed) {
          return SizedBox(
            height: AppHeight.h190,
            child: RetryWidget(
              onReload: () => context.read<GlobalPlatformsBloc>().add(
                const LoadGlobalPlatformsEvent(),
              ),
            ),
          );
        }

        if (state is! GlobalPlatformsLoaded) {
          return SizedBox(
            height: AppHeight.h190,
            child: const LoadingWidget(0),
          );
        }

        final platforms = state.platforms?.platforms ?? const [];
        if (platforms.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: AppHeight.h190,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: platforms.length,
            separatorBuilder: (_, __) => SizedBox(width: AppWidth.w14),
            itemBuilder: (context, index) => ExternalCourseCard(
              platform: platforms[index],
            ),
          ),
        );
      },
    );
  }
}

class ExternalCourseCard extends StatelessWidget {
  const ExternalCourseCard({super.key, required this.platform});

  final GlobalPlatformEntity platform;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.r18),
      onTap: () => LaunchUrlHelper.launchUrlPage(platform.link),
      child: Container(
        width: AppWidth.w280,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r18),
          border: Border.all(color: AppColors.searchCardBorder),
          boxShadow: const [
            BoxShadow(
              color: AppColors.greySec,
              spreadRadius: -1,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ImageView(
                  imagePath: platform.image,
                  width: double.infinity,
                  height: AppHeight.h100,
                  fit: BoxFit.cover,
                ),
                PositionedDirectional(
                  top: AppHeight.h10,
                  start: AppWidth.w10,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPaddingWidth.p10,
                      vertical: AppPaddingHeight.p5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.88),
                      borderRadius: BorderRadius.circular(AppRadius.r20),
                    ),
                    child: BodyTitle(
                      text: platform.tag,
                      color: AppColors.white,
                      fontSize: AppFontSize.s10,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(AppPaddingWidth.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    text: platform.title,
                    color: AppColors.text,
                    fontSize: AppFontSize.s13,
                    fontWeight: AppFontWeight.extraBold,
                    maxLines: 1,
                  ),
                  SizedBox(height: AppHeight.h8),
                  BodyTitle(
                    text: platform.description,
                    color: AppColors.muted,
                    fontSize: AppFontSize.s11,
                    fontWeight: AppFontWeight.semiBold,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
