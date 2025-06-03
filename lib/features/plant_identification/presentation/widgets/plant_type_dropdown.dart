import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/constants.dart';

class PlantTypeDropdown extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onChanged;

  const PlantTypeDropdown({
    Key? key,
    required this.selectedType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plant Type',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppConstants.smallPadding),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            color: AppTheme.backgroundColor,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedType,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconEnabledColor: AppTheme.primaryColor,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppTheme.textPrimaryColor),
              items: AppConstants.plantTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Row(
                    children: [
                      Icon(
                        _getIconForPlantType(type),
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(type),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  IconData _getIconForPlantType(String type) {
    switch (type.toLowerCase()) {
      case 'flower':
        return Icons.local_florist;
      case 'tree':
        return Icons.park;
      case 'shrub':
        return Icons.grass;
      case 'succulent':
        return Icons.eco;
      case 'herb':
        return Icons.spa;
      case 'vine':
        return Icons.nature;
      case 'grass':
        return Icons.grass;
      case 'fern':
        return Icons.nature_people;
      case 'moss':
        return Icons.eco;
      default:
        return Icons.local_florist;
    }
  }
}
