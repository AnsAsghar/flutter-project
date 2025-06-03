import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/constants.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plant Knowledge',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppConstants.defaultPadding),

            // Insight cards
            _buildInsightCard(
              context,
              'Plant Families',
              'Learn about different plant families and their characteristics',
              Icons.account_tree,
              AppTheme.primaryColor,
            ),

            _buildInsightCard(
              context,
              'Care Tips',
              'Essential care instructions for healthy plant growth',
              Icons.spa,
              AppTheme.accentColor,
            ),

            _buildInsightCard(
              context,
              'Seasonal Guide',
              'Best practices for plant care throughout the year',
              Icons.calendar_month,
              Colors.orange,
            ),

            _buildInsightCard(
              context,
              'Common Issues',
              'Identify and solve common plant problems',
              Icons.healing,
              Colors.red,
            ),

            _buildInsightCard(
              context,
              'Plant Benefits',
              'Discover the benefits of different plants',
              Icons.favorite,
              Colors.pink,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: InkWell(
        onTap: () {
          // Navigate to detailed insight page
        },
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: AppConstants.defaultPadding),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppTheme.textSecondaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
