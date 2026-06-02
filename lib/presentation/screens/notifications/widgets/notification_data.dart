enum NotificationType { promotions, system, orders, others }

class NotificationFilterData {
  const NotificationFilterData({required this.label, required this.type});

  final String label;
  final NotificationType type;
}

class NotificationItemData {
  const NotificationItemData({
    required this.title,
    required this.category,
    required this.type,
    required this.description,
    required this.date,
  });

  final String title;
  final String category;
  final NotificationType type;
  final String description;
  final String date;
}

const List<NotificationFilterData> notificationFilters = [
  NotificationFilterData(label: 'Promotions', type: NotificationType.promotions),
  NotificationFilterData(label: 'System', type: NotificationType.system),
  NotificationFilterData(label: 'Orders', type: NotificationType.orders),
  NotificationFilterData(label: 'Others', type: NotificationType.others),
];

const List<NotificationItemData> notificationItems = [
  NotificationItemData(
    title: 'Congrats! Your order successful',
    category: 'Orders',
    type: NotificationType.orders,
    description:
        'Semper consequat pharetra vitae nisl eget lectus. Convallis in turpis quam sed in. Vehicula diam euismod cursus posuere cras urna ultrice.',
    date: 'Jan 28, 2023 04:00 PM',
  ),
  NotificationItemData(
    title: 'Changes in customer service time',
    category: 'Promotions',
    type: NotificationType.promotions,
    description:
        'Semper consequat pharetra vitae nisl eget lectus. Convallis in turpis quam sed in. Vehicula diam euismod cursus posuere cras urna ultrice.',
    date: 'Jan 28, 2023 04:00 PM',
  ),
  NotificationItemData(
    title: 'Changes in customer service time',
    category: 'Others',
    type: NotificationType.others,
    description:
        'Semper consequat pharetra vitae nisl eget lectus. Convallis in turpis quam sed in. Vehicula diam euismod cursus posuere cras urna ultrice.',
    date: 'Jan 05, 2023 11:00 AM',
  ),
];
