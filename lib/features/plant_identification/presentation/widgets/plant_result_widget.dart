import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/entities/plant.dart';

class PlantResultWidget extends StatelessWidget {
  final Plant plant;
  final VoidCallback onSave;

  const PlantResultWidget({Key? key, required this.plant, required this.onSave})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: AppConstants.smallPadding),
                Text(
                  'Plant Identified!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppConstants.defaultPadding),

            // Plant image
            if (plant.imagePath.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                child: Image.file(
                  File(plant.imagePath),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: AppConstants.defaultPadding),

            // Plant information
            _buildInfoSection(context),

            const SizedBox(height: AppConstants.defaultPadding),

            // Confidence score
            if (plant.confidence != null) _buildConfidenceScore(context),

            const SizedBox(height: AppConstants.defaultPadding),

            // Care instructions
            if (plant.careInstructions != null &&
                plant.careInstructions!.isNotEmpty)
              _buildCareInstructions(context),

            const SizedBox(height: AppConstants.largePadding),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.save),
                label: const Text('Save to Collection'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (plant.commonName != null) ...[
          _buildInfoRow(
            context,
            'Common Name',
            plant.commonName!,
            Icons.local_florist,
          ),
          const SizedBox(height: AppConstants.smallPadding),
        ],

        if (plant.scientificName != null) ...[
          _buildInfoRow(
            context,
            'Scientific Name',
            plant.scientificName!,
            Icons.science,
          ),
          const SizedBox(height: AppConstants.smallPadding),
        ],

        _buildInfoRow(context, 'Type', plant.type, Icons.category),

        if (plant.description != null) ...[
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            'Description',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            plant.description!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondaryColor,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppTheme.primaryColor),
        const SizedBox(width: AppConstants.smallPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfidenceScore(BuildContext context) {
    final confidence = (plant.confidence! * 100).round();
    final color = confidence >= 80
        ? AppTheme.primaryColor
        : confidence >= 60
        ? Colors.orange
        : AppTheme.errorColor;

    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.analytics, color: color),
          const SizedBox(width: AppConstants.smallPadding),
          Text(
            'Confidence: $confidence%',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareInstructions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Care Instructions',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppConstants.smallPadding),
        ...plant.careInstructions!.map(
          (instruction) => Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.smallPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppConstants.smallPadding),
                Expanded(
                  child: Text(
                    instruction,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondaryColor,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
