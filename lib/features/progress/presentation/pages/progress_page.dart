import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/constants.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // Stats cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Plants Identified',
                    '0',
                    Icons.local_florist,
                    AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: AppConstants.defaultPadding),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Species Discovered',
                    '0',
                    Icons.science,
                    AppTheme.accentColor,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.defaultPadding),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Days Active',
                    '1',
                    Icons.calendar_today,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: AppConstants.defaultPadding),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Accuracy Rate',
                    '0%',
                    Icons.analytics,
                    Colors.blue,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Progress chart placeholder
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Progress',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 64,
                                color: AppTheme.textSecondaryColor,
                              ),
                              const SizedBox(height: AppConstants.defaultPadding),
                              Text(
                                'Start identifying plants to see your progress',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppTheme.textSecondaryColor,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: AppConstants.smallPadding),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
