import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/constants.dart';
import '../../../plant_identification/domain/entities/plant.dart';

class PlantHistoryItem extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const PlantHistoryItem({
    Key? key,
    required this.plant,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            children: [
              // Plant image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: plant.imagePath.isNotEmpty
                      ? Image.file(
                          File(plant.imagePath),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: AppTheme.surfaceColor,
                          child: Icon(
                            Icons.local_florist,
                            color: AppTheme.primaryColor,
                            size: 32,
                          ),
                        ),
                ),
              ),
              
              const SizedBox(width: AppConstants.defaultPadding),
              
              // Plant information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.commonName ?? 'Unknown Plant',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimaryColor,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    if (plant.scientificName != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        plant.scientificName!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondaryColor,
                              fontStyle: FontStyle.italic,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    
                    const SizedBox(height: 4),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.category,
                          size: 16,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          plant.type,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        
                        if (plant.confidence != null) ...[
                          const SizedBox(width: AppConstants.defaultPadding),
                          Icon(
                            Icons.analytics,
                            size: 16,
                            color: AppTheme.textSecondaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${(plant.confidence! * 100).round()}%',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textSecondaryColor,
                                ),
                          ),
                        ],
                      ],
                    ),
                    
                    const SizedBox(height: 4),
                    
                    Text(
                      _formatDate(plant.timestamp),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                    ),
                  ],
                ),
              ),
              
              // Arrow icon
              Icon(
                Icons.chevron_right,
                color: AppTheme.textSecondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
