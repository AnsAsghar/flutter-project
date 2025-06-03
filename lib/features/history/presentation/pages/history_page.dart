import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../plant_identification/presentation/bloc/plant_identification_bloc.dart';
import '../../../plant_identification/presentation/bloc/plant_identification_event.dart';
import '../../../plant_identification/presentation/bloc/plant_identification_state.dart';
import '../widgets/plant_history_item.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PlantIdentificationBloc>()..add(LoadSavedPlantsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Plant History'),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: BlocBuilder<PlantIdentificationBloc, PlantIdentificationState>(
          builder: (context, state) {
            if (state is PlantIdentificationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SavedPlantsLoaded) {
              if (state.plants.isEmpty) {
                return _buildEmptyState(context);
              }
              return ListView.builder(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                itemCount: state.plants.length,
                itemBuilder: (context, index) {
                  return PlantHistoryItem(
                    plant: state.plants[index],
                    onTap: () {
                      // Navigate to plant details
                    },
                  );
                },
              );
            } else if (state is PlantIdentificationError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppTheme.errorColor,
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    Text(
                      'Error loading history',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppConstants.smallPadding),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PlantIdentificationBloc>().add(LoadSavedPlantsEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return _buildEmptyState(context);
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: AppTheme.textSecondaryColor,
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            'No plants identified yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'Start identifying plants to see your history here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
