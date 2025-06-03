import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/injection_container.dart';
import '../bloc/plant_identification_bloc.dart';
import '../bloc/plant_identification_event.dart';
import '../bloc/plant_identification_state.dart';
import '../widgets/plant_type_dropdown.dart';
import '../widgets/image_picker_widget.dart';
import '../widgets/plant_result_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedPlantType = AppConstants.plantTypes.first;
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PlantIdentificationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AI Plant Identifier'),
          backgroundColor: AppTheme.primaryColor,
        ),
        body: BlocConsumer<PlantIdentificationBloc, PlantIdentificationState>(
          listener: (context, state) {
            if (state is PlantIdentificationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppTheme.errorColor,
                ),
              );
            } else if (state is PlantSaved) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppTheme.primaryColor,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Welcome section
                  _buildWelcomeSection(),

                  const SizedBox(height: AppConstants.largePadding),

                  // Plant type dropdown
                  PlantTypeDropdown(
                    selectedType: _selectedPlantType,
                    onChanged: (value) {
                      setState(() {
                        _selectedPlantType = value;
                      });
                    },
                  ),

                  const SizedBox(height: AppConstants.defaultPadding),

                  // Image picker
                  ImagePickerWidget(
                    selectedImage: _selectedImage,
                    onImageSelected: (image) {
                      setState(() {
                        _selectedImage = image;
                      });
                    },
                  ),

                  const SizedBox(height: AppConstants.largePadding),

                  // Identify button
                  _buildIdentifyButton(context, state),

                  const SizedBox(height: AppConstants.largePadding),

                  // Results section
                  if (state is PlantIdentificationSuccess)
                    PlantResultWidget(
                      plant: state.plant,
                      onSave: () {
                        context.read<PlantIdentificationBloc>().add(
                          SavePlantEvent(
                            imagePath: state.plant.imagePath,
                            type: state.plant.type,
                            commonName: state.plant.commonName,
                            scientificName: state.plant.scientificName,
                            description: state.plant.description,
                            careInstructions: state.plant.careInstructions,
                            confidence: state.plant.confidence,
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to AI Plant Identifier!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            Text(
              'Take a photo of any plant and discover its name, characteristics, and care instructions.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdentifyButton(
    BuildContext context,
    PlantIdentificationState state,
  ) {
    final isLoading = state is PlantIdentificationLoading;
    final canIdentify = _selectedImage != null && !isLoading;

    return ElevatedButton(
      onPressed: canIdentify
          ? () {
              context.read<PlantIdentificationBloc>().add(
                IdentifyPlantEvent(
                  imagePath: _selectedImage!.path,
                  plantType: _selectedPlantType,
                ),
              );
            }
          : null,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text('Identify Plant'),
    );
  }
}
