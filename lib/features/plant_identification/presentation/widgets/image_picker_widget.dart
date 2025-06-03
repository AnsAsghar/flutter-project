import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/constants.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? selectedImage;
  final ValueChanged<File?> onImageSelected;

  const ImagePickerWidget({
    Key? key,
    required this.selectedImage,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plant Image',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppConstants.smallPadding),

        // Image display area
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            color: AppTheme.surfaceColor,
          ),
          child: selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius - 2,
                  ),
                  child: Image.file(selectedImage!, fit: BoxFit.cover),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      size: 48,
                      color: AppTheme.textSecondaryColor,
                    ),
                    const SizedBox(height: AppConstants.smallPadding),
                    Text(
                      'Tap to add plant image',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
        ),

        const SizedBox(height: AppConstants.defaultPadding),

        // Image picker buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                  side: const BorderSide(color: AppTheme.primaryColor),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.defaultPadding),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('Gallery'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                  side: const BorderSide(color: AppTheme.primaryColor),
                ),
              ),
            ),
          ],
        ),

        if (selectedImage != null) ...[
          const SizedBox(height: AppConstants.smallPadding),
          Center(
            child: TextButton.icon(
              onPressed: () => onImageSelected(null),
              icon: const Icon(Icons.clear, color: AppTheme.errorColor),
              label: const Text(
                'Remove Image',
                style: TextStyle(color: AppTheme.errorColor),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: AppConstants.maxImageSize,
        maxHeight: AppConstants.maxImageSize,
        imageQuality: AppConstants.imageQuality,
      );

      if (image != null) {
        onImageSelected(File(image.path));
      }
    } catch (e) {
      // Handle error - could show a snackbar or dialog
      debugPrint('Error picking image: $e');
    }
  }
}
