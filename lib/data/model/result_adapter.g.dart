// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApiResponseAdapter extends TypeAdapter<ApiResponse> {
  @override
  final int typeId = 0;

  @override
  ApiResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApiResponse(
      url: fields[0] as String,
      response: fields[1] as String,
      timestamp: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ApiResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.response)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
