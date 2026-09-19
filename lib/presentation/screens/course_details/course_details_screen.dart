import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';
import 'package:wlcd/presentation/bloc/course_details/get_course_details/get_course_details_bloc.dart';
import 'package:wlcd/presentation/bloc/favorites/add_favorite_membership/add_favorite_membership_bloc.dart';
import 'package:wlcd/presentation/bloc/favorites/create_favorite_group/create_favorite_group_bloc.dart';
import 'package:wlcd/presentation/bloc/favorites/favorite_groups/favorite_groups_bloc.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

import 'widgets/about_tab.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final entity = CourseDetailsEntity(courseId: courseId);
    return BlocProvider(
      create: (_) => GetCourseDetailsBloc()..add(LoadGetCourseDetailsEvent(entity)),
      child: _CourseDetailsBody(entity: entity),
    );
  }
}

class _CourseDetailsBody extends StatelessWidget {
  const _CourseDetailsBody({required this.entity});

  final CourseDetailsEntity entity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourseDetailsBloc, IGetCourseDetailsState>(
      builder: (context, state) {
        if (state is GetCourseDetailsFailed) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: RetryWidget(
              onReload: () => context.read<GetCourseDetailsBloc>().add(LoadGetCourseDetailsEvent(entity)),
            ),
          );
        }
        if (state is! GetCourseDetailsLoaded || state.getCourseDetails == null) {
          return const Scaffold(backgroundColor: AppColors.white, body: LoadingWidget(0));
        }
        return _buildDetails(context, state.getCourseDetails!);
      },
    );
  }

  Widget _buildDetails(BuildContext context, CourseDetailsModel course) {
    final thumbnailUrl = course.thumbnail?['url']?.toString();
    final availableTabs = _buildAvailableTabs(course);
    return DefaultTabController(
      length: availableTabs.length,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(
              AppPaddingWidth.p18,
              AppPaddingHeight.p8,
              AppPaddingWidth.p18,
              AppPaddingHeight.p14,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              heightFactor: 1,
              child: Container(
                height: AppHeight.h52,
                width: AppWidth.w52,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.searchCardBorder),
                  borderRadius: BorderRadius.circular(AppRadius.r14),
                ),
                child: IconButton(
                  onPressed: () => _showFavoriteGroupsSheet(context, courseId: course.courseId),
                  icon: const Icon(Icons.favorite_border, color: AppColors.primary),
                ),
              ),
            ),
          ),
          body: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 290,
                  backgroundColor: AppColors.white,
                  surfaceTintColor: Colors.transparent,
                  pinned: true,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.black),
                  ),
                  actions: const [
                    Icon(Icons.ios_share_outlined, color: AppColors.black, size: 20),
                    SizedBox(width: 12),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppPaddingWidth.p18,
                        AppPaddingHeight.p55,
                        AppPaddingWidth.p18,
                        AppPaddingHeight.p10,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.r14),
                        child: ImageView(
                          imagePath: thumbnailUrl ?? '',
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p18),
                    child: Column(
                      children: [
                        SizedBox(height: AppHeight.h14),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPaddingWidth.p8,
                                vertical: AppPaddingHeight.p4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.searchTagBackground,
                                borderRadius: BorderRadius.circular(AppRadius.r8),
                              ),
                              child: BodyTitle(
                                text: course.language ?? '',
                                fontSize: 10,
                                color: AppColors.searchTagText,
                              ),
                            ),
                            const Spacer(),
                            BodyTitle(
                              text: _formatDuration(course.estimatedDurationSeconds),
                              fontSize: 12,
                              color: AppColors.searchRatingText,
                            ),
                            SizedBox(width: AppWidth.w8),
                            BodyTitle(text: course.difficulty, fontSize: 12, color: AppColors.searchCardTitle),
                          ],
                        ),
                        SizedBox(height: AppHeight.h10),
                        SectionTitle(
                          text: course.title,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: AppColors.searchCardTitle,
                          height: 1.3,
                        ),
                        SizedBox(height: AppHeight.h16),
                      ],
                    ),
                  ),
                ),
                SliverAppBar(
                  pinned: true,
                  toolbarHeight: 0,

                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(65),
                    child: Container(
                      color: AppColors.white,
                      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p12),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(AppRadius.r12),
                        ),
                        child: TabBar(
                          tabs: [for (final item in availableTabs) item.tab],
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                          ),
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.searchRatingText,
                          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                          padding: EdgeInsets.all(AppPaddingWidth.p4),
                          labelPadding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p12),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [for (final item in availableTabs) item.page],
            ),
          ),
        ),
      ),
    );
  }

  List<_CourseDetailsTab> _buildAvailableTabs(CourseDetailsModel course) {
    final tabs = <_CourseDetailsTab>[];
    for (final availableTab in course.availableTabs) {
      // The current contract only proves the `overview` projection used by
      // the model fixture. Other values stay opaque until the generated
      // OpenAPI model defines their structure and enum values.
      if (availableTab case {'type': 'overview'}) {
        tabs.add(
          _CourseDetailsTab(
            tab: const Tab(text: 'About'),
            page: AboutTab(description: course.description),
          ),
        );
      }
    }

    // The course description is part of the documented discovery response,
    // so it is the only safe fallback when no typed tab projection is known.
    if (tabs.isEmpty) {
      tabs.add(
        _CourseDetailsTab(
          tab: const Tab(text: 'About'),
          page: AboutTab(description: course.description),
        ),
      );
    }
    return tabs;
  }
}

class _CourseDetailsTab {
  const _CourseDetailsTab({required this.tab, required this.page});

  final Tab tab;
  final Widget page;
}

String _formatDuration(int? totalSeconds) {
  if (totalSeconds == null || totalSeconds <= 0) return '—';
  final hours = totalSeconds ~/ Duration.secondsPerHour;
  final minutes = (totalSeconds % Duration.secondsPerHour) ~/ Duration.secondsPerMinute;
  if (hours == 0) return '${minutes}m';
  return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
}

void _showFavoriteGroupsSheet(BuildContext context, {required String courseId}) {
  final messenger = ScaffoldMessenger.of(context);
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.r24)),
    ),
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FavoriteGroupsBloc()..add(const LoadFavoriteGroupsEvent()),
        ),
        BlocProvider(create: (_) => CreateFavoriteGroupBloc()),
        BlocProvider(create: (_) => AddFavoriteMembershipBloc()),
      ],
      child: _FavoriteGroupsSheet(courseId: courseId, messenger: messenger),
    ),
  );
}

class _FavoriteGroupsSheet extends StatefulWidget {
  const _FavoriteGroupsSheet({required this.courseId, required this.messenger});

  final String courseId;
  final ScaffoldMessengerState messenger;

  @override
  State<_FavoriteGroupsSheet> createState() => _FavoriteGroupsSheetState();
}

class _FavoriteGroupsSheetState extends State<_FavoriteGroupsSheet> {
  final _groupController = TextEditingController();
  final Map<String, String> _membershipKeys = {};
  String? _createGroupKey;
  String? _createGroupName;

  @override
  void dispose() {
    _groupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateFavoriteGroupBloc, ICreateFavoriteGroupState>(
          listener: (context, state) {
            if (state is CreateFavoriteGroupFailed) {
              _showMessage(state.message);
            } else if (state is CreateFavoriteGroupSucceeded && state.group != null) {
              _addCourseToGroup(context, state.group!.favoriteGroupId);
            }
          },
        ),
        BlocListener<AddFavoriteMembershipBloc, IAddFavoriteMembershipState>(
          listener: (context, state) {
            if (state is AddFavoriteMembershipFailed) {
              _showMessage(state.message);
            } else if (state is AddFavoriteMembershipSucceeded) {
              Navigator.of(context).pop();
              widget.messenger.showSnackBar(
                const SnackBar(content: Text('تمت إضافة الكورس إلى المفضلة')),
              );
            }
          },
        ),
      ],
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          AppPaddingWidth.p18,
          AppPaddingHeight.p18,
          AppPaddingWidth.p18,
          MediaQuery.viewInsetsOf(context).bottom + AppPaddingHeight.p18,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: AppWidth.w45,
                height: AppHeight.h4,
                decoration: BoxDecoration(
                  color: AppColors.searchCardBorder,
                  borderRadius: BorderRadius.circular(AppRadius.r10),
                ),
              ),
            ),
            SizedBox(height: AppHeight.h18),
            const SectionTitle(
              text: 'إضافة إلى مجموعة',
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: AppHeight.h8),
            const BodyTitle(
              text: 'اختر مجموعة موجودة أو أنشئ مجموعة جديدة.',
              color: AppColors.muted,
              fontSize: 13,
            ),
            SizedBox(height: AppHeight.h18),
            Flexible(child: _buildGroups(context)),
            SizedBox(height: AppHeight.h14),
            TextField(
              controller: _groupController,
              textInputAction: TextInputAction.done,
              onChanged: (_) {
                _createGroupKey = null;
                _createGroupName = null;
              },
              decoration: InputDecoration(
                hintText: 'اسم مجموعة جديدة',
                filled: true,
                fillColor: AppColors.backGround,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r14),
                  borderSide: const BorderSide(color: AppColors.searchCardBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r14),
                  borderSide: const BorderSide(color: AppColors.searchCardBorder),
                ),
              ),
            ),
            SizedBox(height: AppHeight.h12),
            _buildCreateButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGroups(BuildContext context) {
    return BlocBuilder<FavoriteGroupsBloc, IFavoriteGroupsState>(
      builder: (context, state) {
        if (state is FavoriteGroupsFailed) {
          return RetryWidget(
            onReload: () => context.read<FavoriteGroupsBloc>().add(
              const LoadFavoriteGroupsEvent(),
            ),
          );
        }
        if (state is! FavoriteGroupsLoaded) {
          return const SizedBox(height: 120, child: LoadingWidget(0));
        }

        final groups = state.groups?.data ?? const <Map<String, dynamic>>[];
        if (groups.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: BodyTitle(
                text: 'لا توجد مجموعات مفضلة. أنشئ مجموعة جديدة أدناه.',
                color: AppColors.muted,
                fontSize: 13,
                maxLines: 2,
              ),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          itemCount: groups.length,
          separatorBuilder: (_, __) => Divider(
            color: AppColors.searchCardBorder,
            height: AppHeight.h18,
          ),
          itemBuilder: (context, index) {
            final group = groups[index];
            final groupId = group['favoriteGroupId'];
            final name = group['name'];
            final canSelect = groupId is String && groupId.isNotEmpty;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              enabled: canSelect,
              leading: CircleAvatar(
                backgroundColor: AppColors.lightPrim,
                child: const Icon(Icons.folder_rounded, color: AppColors.primary),
              ),
              title: SectionTitle(
                text: name is String && name.isNotEmpty ? name : 'مجموعة مفضلة ${index + 1}',
                color: AppColors.text,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              onTap: canSelect ? () => _addCourseToGroup(context, groupId) : null,
            );
          },
        );
      },
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return BlocBuilder<CreateFavoriteGroupBloc, ICreateFavoriteGroupState>(
      builder: (context, createState) {
        return BlocBuilder<AddFavoriteMembershipBloc, IAddFavoriteMembershipState>(
          builder: (context, membershipState) {
            final isLoading =
                createState is CreateFavoriteGroupLoading ||
                membershipState is AddFavoriteMembershipLoading;
            return SizedBox(
              width: double.infinity,
              height: AppHeight.h52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r28),
                  ),
                ),
                onPressed: isLoading ? null : () => _createGroup(context),
                icon: isLoading
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white),
                      )
                    : const Icon(Icons.add_rounded, color: AppColors.white),
                label: const BodyTitle(
                  text: 'إنشاء وإضافة الكورس',
                  color: AppColors.white,
                  fontSize: 15,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _createGroup(BuildContext context) {
    final name = _groupController.text.trim();
    if (name.isEmpty) {
      _showMessage('يرجى إدخال اسم المجموعة');
      return;
    }
    if (_createGroupName != name || _createGroupKey == null) {
      _createGroupName = name;
      _createGroupKey = _newIdempotencyKey();
    }
    context.read<CreateFavoriteGroupBloc>().add(
      SubmitCreateFavoriteGroupEvent(
        FavoritesEntity(name: name, idempotencyKey: _createGroupKey),
      ),
    );
  }

  void _addCourseToGroup(BuildContext context, String favoriteGroupId) {
    final key = _membershipKeys.putIfAbsent(favoriteGroupId, _newIdempotencyKey);
    context.read<AddFavoriteMembershipBloc>().add(
      SubmitAddFavoriteMembershipEvent(
        FavoritesEntity(
          favoriteGroupId: favoriteGroupId,
          courseId: widget.courseId,
          idempotencyKey: key,
        ),
      ),
    );
  }

  void _showMessage(String message) {
    widget.messenger.showSnackBar(SnackBar(content: Text(message)));
  }
}

String _newIdempotencyKey() {
  final random = Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;
  final hex = bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
      '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}
