import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/Search/widgets/search_course_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key, required this.courses, required this.tabController});
  final List<SearchCourseData> courses;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) return const Center(child: BodyTitle(text: 'No courses found'));
    return TabBarView(
      controller: tabController,
      children: [
        GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: courses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: AppWidth.w12, mainAxisSpacing: AppHeight.h12, childAspectRatio: .68),
          itemBuilder: (_, i) => _GridCard(course: courses[i]),
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: courses.length,
          separatorBuilder: (_, __) => SizedBox(height: AppHeight.h12),
          itemBuilder: (_, i) => _ListCard(course: courses[i]),
        ),
      ],
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({required this.course});
  final SearchCourseData course;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddingWidth.p10),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppRadius.r12), border: Border.all(color: AppColors.lightGrey)),
      child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(AppRadius.r8), child: Image.network(course.imageUrl, width: AppWidth.w100, height: AppHeight.h85, fit: BoxFit.cover)),
        SizedBox(width: AppWidth.w10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: const Color(0xffdcfce7), borderRadius: BorderRadius.circular(4)), child: Text(course.category, style: const TextStyle(color: Color(0xff16a34a), fontSize: 9, fontWeight: FontWeight.w700))),
          SizedBox(height: AppHeight.h6),
          Text(course.title, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xff111827))),
          SizedBox(height: AppHeight.h6),
          Text('\$${course.price.toStringAsFixed(2)}', style: const TextStyle(color: Color(0xff2563eb), fontWeight: FontWeight.w800)),
          Row(children: [const Icon(Icons.star, color: Color(0xfff6b93b), size: 14), Text(' ${course.rating} (${course.reviews})', style: const TextStyle(color: Color(0xff6b7280), fontSize: 13))]),
        ]))
      ]),
    );
  }
}

class _GridCard extends StatelessWidget {
  const _GridCard({required this.course});
  final SearchCourseData course;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddingWidth.p8),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppRadius.r10), border: Border.all(color: AppColors.lightGrey)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(AppRadius.r8), child: Image.network(course.imageUrl, height: AppHeight.h95, width: double.infinity, fit: BoxFit.cover)),
        SizedBox(height: AppHeight.h8),
        Text(course.category, style: const TextStyle(color: Color(0xff16a34a), fontSize: 9, fontWeight: FontWeight.w700)),
        SizedBox(height: AppHeight.h5),
        Expanded(child: Text(course.title, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13))),
        Text('\$${course.price.toStringAsFixed(2)}', style: const TextStyle(color: Color(0xff2563eb), fontWeight: FontWeight.w800)),
        Row(children: [const Icon(Icons.star, color: Color(0xfff6b93b), size: 14), Text(' ${course.rating}', style: const TextStyle(color: Color(0xff6b7280), fontSize: 13))]),
      ]),
    );
  }
}
