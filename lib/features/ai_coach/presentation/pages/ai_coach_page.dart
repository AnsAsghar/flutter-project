import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/constants.dart';

class AICoachPage extends StatelessWidget {
  const AICoachPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Plant Coach'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // AI Coach introduction
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadius,
                        ),
                      ),
                      child: Icon(
                        Icons.psychology,
                        color: AppTheme.primaryColor,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: AppConstants.defaultPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Plant Coach',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Get personalized plant care advice and tips',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppConstants.defaultPadding),

            // Quick help topics
            Text(
              'Quick Help Topics',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppConstants.defaultPadding),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: AppConstants.defaultPadding,
                mainAxisSpacing: AppConstants.defaultPadding,
                children: [
                  _buildHelpTopic(
                    context,
                    'Watering Tips',
                    Icons.water_drop,
                    Colors.blue,
                  ),
                  _buildHelpTopic(
                    context,
                    'Light Requirements',
                    Icons.wb_sunny,
                    Colors.orange,
                  ),
                  _buildHelpTopic(
                    context,
                    'Soil & Fertilizer',
                    Icons.grass,
                    Colors.brown,
                  ),
                  _buildHelpTopic(
                    context,
                    'Pest Control',
                    Icons.bug_report,
                    Colors.red,
                  ),
                  _buildHelpTopic(
                    context,
                    'Pruning Guide',
                    Icons.content_cut,
                    Colors.green,
                  ),
                  _buildHelpTopic(
                    context,
                    'Troubleshooting',
                    Icons.help_outline,
                    Colors.purple,
                  ),
                ],
              ),
            ),

            // Chat input
            Container(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ask your plant question...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Send message to AI coach
                    },
                    icon: Icon(Icons.send, color: AppTheme.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpTopic(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          // Navigate to specific help topic
        },
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: AppConstants.smallPadding),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
