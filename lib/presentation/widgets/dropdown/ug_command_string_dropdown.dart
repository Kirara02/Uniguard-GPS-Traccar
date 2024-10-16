import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gps_tracker/presentation/misc/colors.dart';
import 'package:gps_tracker/presentation/misc/typography.dart';

class UgCommandStringDropdown extends StatelessWidget {
  final GlobalKey<DropdownSearchState>? dropdownKey;
  final String label;
  final List<String> items;
  final String? selectedItem;
  final Function(String?)? onChanged;

  const UgCommandStringDropdown({
    super.key,
    this.dropdownKey,
    required this.label,
    required this.items,
    this.selectedItem,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      key: dropdownKey,
      items: items,
      selectedItem: selectedItem,
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
