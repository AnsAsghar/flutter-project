import 'package:hive/hive.dart';
import '../../domain/entities/plant.dart';

part 'plant_model.g.dart';

@HiveType(typeId: 0)
class PlantModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String? commonName;

  @HiveField(4)
  final String? scientificName;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  final List<String>? careInstructions;

  @HiveField(7)
  final double? confidence;

  @HiveField(8)
  final DateTime timestamp;

  PlantModel({
    required this.id,
    required this.imagePath,
    required this.type,
    this.commonName,
    this.scientificName,
    this.description,
    this.careInstructions,
    this.confidence,
    required this.timestamp,
  });

  /// Convert from domain entity to data model
  factory PlantModel.fromEntity(Plant plant) {
    return PlantModel(
      id: plant.id,
      imagePath: plant.imagePath,
      type: plant.type,
      commonName: plant.commonName,
      scientificName: plant.scientificName,
      description: plant.description,
      careInstructions: plant.careInstructions,
      confidence: plant.confidence,
      timestamp: plant.timestamp,
    );
  }

  /// Convert from data model to domain entity
  Plant toEntity() {
    return Plant(
      id: id,
      imagePath: imagePath,
      type: type,
      commonName: commonName,
      scientificName: scientificName,
      description: description,
      careInstructions: careInstructions,
      confidence: confidence,
      timestamp: timestamp,
    );
  }

  /// Convert from JSON
  factory PlantModel.fromJson(Map<String, dynamic> json) {
    return PlantModel(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      type: json['type'] as String,
      commonName: json['commonName'] as String?,
      scientificName: json['scientificName'] as String?,
      description: json['description'] as String?,
      careInstructions: (json['careInstructions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      confidence: (json['confidence'] as num?)?.toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'type': type,
      'commonName': commonName,
      'scientificName': scientificName,
      'description': description,
      'careInstructions': careInstructions,
      'confidence': confidence,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
