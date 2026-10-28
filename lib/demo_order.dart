class DemoOrder {
  DemoOrder({
    required this.address,
    required this.contact,
    required this.paymentMethod,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final String address;
  final String contact;
  final String paymentMethod;
  final DateTime createdAt;
  final double total = 12;

  String get id => 'DEMO-${createdAt.microsecondsSinceEpoch}';
  String get date => createdAt.toLocal().toString().split(' ').first;
}
