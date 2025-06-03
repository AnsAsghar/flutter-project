// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantModelAdapter extends TypeAdapter<PlantModel> {
  @override
  final int typeId = 0;

  @override
  PlantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlantModel(
      id: fields[0] as String,
      imagePath: fields[1] as String,
      type: fields[2] as String,
      commonName: fields[3] as String?,
      scientificName: fields[4] as String?,
      description: fields[5] as String?,
      careInstructions: (fields[6] as List?)?.cast<String>(),
      confidence: fields[7] as double?,
      timestamp: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PlantModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.commonName)
      ..writeByte(4)
      ..write(obj.scientificName)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.careInstructions)
      ..writeByte(7)
      ..write(obj.confidence)
      ..writeByte(8)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
