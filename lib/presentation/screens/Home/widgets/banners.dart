import 'package:wlcd/core/resources/app_assets.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannersWidget extends StatelessWidget {
  const BannersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h200,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 3,
        itemBuilder: (context, index, realIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ImageView(
              radius: BorderRadius.circular(AppRadius.r7),
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
              imagePath:
                  "https://c8.alamy.com/comp/2XA6A91/an-ai-generated-illustration-of-the-word-academy-on-a-gray-background-of-a-modern-building-2XA6A91.jpg",
            ),
          );
        },
        options: CarouselOptions(
          viewportFraction: .9,
          enlargeCenterPage: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
      ),
    );
  }
}
