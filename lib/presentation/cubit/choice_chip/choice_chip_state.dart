part of 'choice_chip_cubit.dart';

class ChoiceChipState {
  final String selectedValue;
  final List<ChoiceChipItem> items;

  ChoiceChipState({
    required this.selectedValue,
    required this.items,
  });

  ChoiceChipState copyWith({
    String? selectedValue,
    List<ChoiceChipItem>? items,
  }) {
    return ChoiceChipState(
      selectedValue: selectedValue ?? this.selectedValue,
      items: items ?? this.items,
    );
  }
}

class ChoiceChipItem {
  final String label;
  final String value;

  ChoiceChipItem({required this.label, required this.value});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChoiceChipItem && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}