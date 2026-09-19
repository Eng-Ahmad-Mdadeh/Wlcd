import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/date_time_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/data/model/notifications/notification/notification_model.dart';
import 'package:wlcd/domain/entity/notifications/list_notifications_entity.dart';
import 'package:wlcd/domain/entity/notifications/notification_command_entity.dart';
import 'package:wlcd/presentation/bloc/notifications/get_notification/get_notification_bloc.dart';
import 'package:wlcd/presentation/bloc/notifications/get_notification_preferences/get_notification_preferences_bloc.dart';
import 'package:wlcd/presentation/bloc/notifications/list_notifications/list_notifications_bloc.dart';
import 'package:wlcd/presentation/bloc/notifications/mark_all_notifications_read/mark_all_notifications_read_bloc.dart';
import 'package:wlcd/presentation/bloc/notifications/mark_notification_read/mark_notification_read_bloc.dart';
import 'package:wlcd/presentation/bloc/notifications/unread_notification_count/unread_notification_count_bloc.dart';
import 'package:wlcd/presentation/bloc/notifications/update_notification_preferences/update_notification_preferences_bloc.dart';
import 'package:wlcd/presentation/cubit/notifications/notifications_cubit.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_data.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_header.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_home_indicator.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_list.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/no_result_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NotificationsCubit()),
        BlocProvider(
          create: (_) => ListNotificationsBloc()..add(const LoadNotificationsEvent(ListNotificationsEntity())),
        ),
        BlocProvider(create: (_) => UnreadNotificationCountBloc()..add(const LoadUnreadNotificationCountEvent())),
        BlocProvider(create: (_) => MarkAllNotificationsReadBloc()),
        BlocProvider(create: (_) => GetNotificationBloc()),
        BlocProvider(create: (_) => MarkNotificationReadBloc()),
        BlocProvider(create: (_) => GetNotificationPreferencesBloc()..add(const LoadNotificationPreferencesEvent())),
        BlocProvider(create: (_) => UpdateNotificationPreferencesBloc()),
      ],
      child: const _NotificationsBody(),
    );
  }
}

class _NotificationsBody extends StatelessWidget {
  const _NotificationsBody();

  void _reload(BuildContext context) {
    context.read<ListNotificationsBloc>().add(LoadNotificationsEvent(context.read<NotificationsCubit>().state));
    context.read<UnreadNotificationCountBloc>().add(const LoadUnreadNotificationCountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MarkAllNotificationsReadBloc, IMarkAllNotificationsReadState>(
          listenWhen: (_, state) => state is MarkAllNotificationsReadLoaded,
          listener: (context, _) => _reload(context),
        ),
        BlocListener<MarkNotificationReadBloc, IMarkNotificationReadState>(
          listenWhen: (_, state) => state is MarkNotificationReadLoaded,
          listener: (context, _) => _reload(context),
        ),
        BlocListener<GetNotificationBloc, IGetNotificationState>(
          listenWhen: (_, state) => state is GetNotificationLoaded,
          listener: (context, state) {
            final notification = (state as GetNotificationLoaded).notification;
            if (notification != null && notification.readState.toLowerCase() == 'unread') {
              context.read<MarkNotificationReadBloc>().add(
                MarkNotificationReadEvent(NotificationCommandEntity(notificationId: notification.notificationId)),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'الإشعارات',
          centerTitle: true,
          customActions: [
            BlocBuilder<MarkAllNotificationsReadBloc, IMarkAllNotificationsReadState>(
              builder: (context, state) => IconButton(
                tooltip: 'تحديد الكل كمقروء',
                onPressed: state is MarkAllNotificationsReadLoading
                    ? null
                    : () => context.read<MarkAllNotificationsReadBloc>().add(const MarkAllNotificationsReadEvent()),
                icon: state is MarkAllNotificationsReadLoading
                    ? const SizedBox.square(dimension: 20, child: LoadingWidget(0))
                    : const Icon(Icons.done_all),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.notificationBackground,
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppWidth.w428),
            child: Column(
              children: [
                // const NotificationsHeader(filters: notificationFilters),
                Expanded(child: _buildNotifications(context)),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotifications(BuildContext context) {
    return BlocBuilder<ListNotificationsBloc, IListNotificationsState>(
      builder: (context, state) {
        if (state is ListNotificationsFailed) {
          return RetryWidget(onReload: () => _reload(context));
        }
        if (state is ListNotificationsLoaded) {
          final notifications = state.notifications?.data ?? const [];
          if (notifications.isEmpty) {
            return const NoResultWidget(title: 'لا توجد إشعارات');
          }
          return NotificationsList(
            notifications: notifications.map(_toItemData).toList(),
            onNotificationTap: (index) {
              context.read<GetNotificationBloc>().add(
                LoadNotificationEvent(NotificationCommandEntity(notificationId: notifications[index].notificationId)),
              );
            },
          );
        }
        return const LoadingWidget(0);
      },
    );
  }

  NotificationItemData _toItemData(NotificationModel notification) => NotificationItemData(
    title: notification.title,
    category: notification.category,
    type: _notificationType(notification.category),
    description: notification.body,
    date: notification.createdAt.toLocal().formatWithPattern('MMM dd, yyyy hh:mm a'),
  );

  NotificationType _notificationType(String category) {
    return switch (category.toLowerCase()) {
      'promotions' => NotificationType.promotions,
      'system' => NotificationType.system,
      'orders' => NotificationType.orders,
      _ => NotificationType.others,
    };
  }
}
