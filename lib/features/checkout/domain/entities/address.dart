
class Address {
  Address({
    required this.id,
    required this.label,
    required this.details,
    this.isDefault = false,
  });
  final String id;
  final String label; // e.g., "Home", "Office"
  final String details; // street, city...
  final bool isDefault;

  Address copyWith(
          {String? id, String? label, String? details, bool? isDefault}) =>
      Address(
        id: id ?? this.id,
        label: label ?? this.label,
        details: details ?? this.details,
        isDefault: isDefault ?? this.isDefault,
      );
}
