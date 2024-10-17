import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gps_tracker/presentation/misc/colors.dart';
import 'package:gps_tracker/presentation/misc/typography.dart';

class UgCommandTypeDropdown extends StatelessWidget {
  final GlobalKey<DropdownSearchState>? dropdownKey;
  final String label;
  final List<CommandType> items;
  final CommandType? selectedItem;
  final Function(CommandType?)? onChanged;

  const UgCommandTypeDropdown({
    super.key,
    this.dropdownKey,
    required this.label,
    required this.items,
    this.selectedItem,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<CommandType>(
      key: dropdownKey,
      items: items,
      selectedItem: selectedItem,
      itemAsString: (CommandType? type) => type?.text ?? '',
      onChanged: onChanged,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: label,
          labelStyle: Typogaphy.Regular.copyWith(
            color: AppColors.secondarySoft,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryExtraSoft),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryExtraSoft),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error, width: 1.2),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
      popupProps: const PopupProps.menu(
        showSearchBox: false,
        fit: FlexFit.loose,
        constraints: BoxConstraints(),
      ),
    );
  }
}

class CommandType {
  final String text;
  final String value;

  CommandType({required this.text, required this.value});
}
