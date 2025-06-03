import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/app_theme.dart';

class OnboardingContentWidget extends StatelessWidget {
  final OnboardingContent content;

  const OnboardingContentWidget({Key? key, required this.content})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder for image (since we don't have actual images)
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Icon(
              _getIconForPage(),
              size: 120,
              color: AppTheme.primaryColor,
            ),
          ),

          const SizedBox(height: AppConstants.largePadding * 2),

          // Title
          Text(
            content.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppConstants.defaultPadding),

          // Description
          Text(
            content.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondaryColor,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getIconForPage() {
    if (content.title.contains('Diversity')) {
      return Icons.eco;
    } else if (content.title.contains('Details')) {
      return Icons.info_outline;
    } else {
      return Icons.camera_alt;
    }
  }
}
