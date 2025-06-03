import 'package:equatable/equatable.dart';

class Plant extends Equatable {
  final String id;
  final String imagePath;
  final String type;
  final String? commonName;
  final String? scientificName;
  final String? description;
  final List<String>? careInstructions;
  final double? confidence;
  final DateTime timestamp;

  const Plant({
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

  @override
  List<Object?> get props => [
        id,
        imagePath,
        type,
        commonName,
        scientificName,
        description,
        careInstructions,
        confidence,
        timestamp,
      ];

  Plant copyWith({
    String? id,
    String? imagePath,
    String? type,
    String? commonName,
    String? scientificName,
    String? description,
    List<String>? careInstructions,
    double? confidence,
    DateTime? timestamp,
  }) {
    return Plant(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      type: type ?? this.type,
      commonName: commonName ?? this.commonName,
      scientificName: scientificName ?? this.scientificName,
      description: description ?? this.description,
      careInstructions: careInstructions ?? this.careInstructions,
      confidence: confidence ?? this.confidence,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
