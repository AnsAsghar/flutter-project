import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/constants.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Diary'),
        backgroundColor: AppTheme.primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              // Add new diary entry
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search diary entries...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.defaultPadding),
            
            // Empty state
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book,
                      size: 64,
                      color: AppTheme.textSecondaryColor,
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    Text(
                      'Your Plant Diary',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                    ),
                    const SizedBox(height: AppConstants.smallPadding),
                    Text(
                      'Record your plant care journey, observations, and memories',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.largePadding),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add first diary entry
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add First Entry'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
