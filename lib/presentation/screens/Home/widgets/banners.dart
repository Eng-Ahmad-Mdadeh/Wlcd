import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/bloc/catalog/banners/banners_bloc.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';

class BannersWidget extends StatelessWidget {
  const BannersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersBloc, IBannersState>(
      builder: (context, state) {
        if (state is BannersFailed) {
          return SizedBox(
            height: AppHeight.h370,
            child: RetryWidget(
              onReload: () => context.read<BannersBloc>().add(
                const LoadBannersEvent(),
              ),
            ),
          );
        }

        if (state is! BannersLoaded) {
          return SizedBox(
            height: AppHeight.h370,
            child: const LoadingWidget(0),
          );
        }

        final banners = state.banners?.banners ?? const [];
        if (banners.isEmpty) return const SizedBox.shrink();

        return CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder: (context, index, realIndex) => ImageView(
            radius: BorderRadius.circular(AppRadius.r24),
            margin: EdgeInsets.symmetric(horizontal: AppMarginWidth.m8),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            imagePath: banners[index].image,
          ),
          options: CarouselOptions(
            clipBehavior: Clip.none,
            viewportFraction: 0.72,
            enlargeCenterPage: false,
            autoPlay: banners.length > 1,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            scrollDirection: Axis.horizontal,
            height: AppHeight.h370,
            enableInfiniteScroll: banners.length > 1,
          ),
        );
      },
    );
  }
}
