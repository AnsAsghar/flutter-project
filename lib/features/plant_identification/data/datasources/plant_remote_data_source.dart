import 'dart:math';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/plant_model.dart';

abstract class PlantRemoteDataSource {
  Future<PlantModel> identifyPlant({
    required String imagePath,
    required String plantType,
  });
}

class PlantRemoteDataSourceImpl implements PlantRemoteDataSource {
  final http.Client client;

  PlantRemoteDataSourceImpl({required this.client});

  @override
  Future<PlantModel> identifyPlant({
    required String imagePath,
    required String plantType,
  }) async {
    // For demo purposes, we'll simulate plant identification
    // In a real app, this would call an actual plant identification API
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Generate mock plant data based on the selected type
      final mockPlantData = _generateMockPlantData(plantType, imagePath);

      return PlantModel.fromJson(mockPlantData);
    } catch (e) {
      throw ServerException('Failed to identify plant: ${e.toString()}');
    }
  }

  Map<String, dynamic> _generateMockPlantData(
    String plantType,
    String imagePath,
  ) {
    final random = Random();
    final confidence = 0.7 + (random.nextDouble() * 0.3); // 70-100% confidence

    // Mock plant data based on type
    final plantData = _getMockPlantDataByType(plantType);

    return {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'imagePath': imagePath,
      'type': plantType,
      'commonName': plantData['commonName'],
      'scientificName': plantData['scientificName'],
      'description': plantData['description'],
      'careInstructions': plantData['careInstructions'],
      'confidence': confidence,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> _getMockPlantDataByType(String plantType) {
    final mockData = {
      'Flower': {
        'commonName': 'Rose',
        'scientificName': 'Rosa rubiginosa',
        'description':
            'A beautiful flowering plant known for its fragrant blooms and thorny stems.',
        'careInstructions': [
          'Water regularly but avoid overwatering',
          'Provide 6+ hours of sunlight daily',
          'Prune dead flowers to encourage new blooms',
          'Apply fertilizer during growing season',
        ],
      },
      'Tree': {
        'commonName': 'Oak Tree',
        'scientificName': 'Quercus robur',
        'description':
            'A large deciduous tree known for its strength and longevity.',
        'careInstructions': [
          'Plant in well-draining soil',
          'Water deeply but infrequently',
          'Prune during dormant season',
          'Protect from strong winds when young',
        ],
      },
      'Succulent': {
        'commonName': 'Aloe Vera',
        'scientificName': 'Aloe barbadensis',
        'description':
            'A succulent plant species known for its medicinal properties.',
        'careInstructions': [
          'Water sparingly, allow soil to dry between waterings',
          'Provide bright, indirect sunlight',
          'Use well-draining cactus soil',
          'Avoid overwatering to prevent root rot',
        ],
      },
      'Herb': {
        'commonName': 'Basil',
        'scientificName': 'Ocimum basilicum',
        'description':
            'An aromatic herb commonly used in cooking and traditional medicine.',
        'careInstructions': [
          'Water regularly to keep soil moist',
          'Provide 6-8 hours of sunlight daily',
          'Pinch flowers to encourage leaf growth',
          'Harvest leaves regularly for best flavor',
        ],
      },
    };

    return mockData[plantType] ??
        {
          'commonName': 'Unknown Plant',
          'scientificName': 'Species unknown',
          'description': 'This plant requires further identification.',
          'careInstructions': [
            'Provide adequate water and sunlight',
            'Monitor for signs of disease or pests',
            'Research specific care requirements',
          ],
        };
  }
}
