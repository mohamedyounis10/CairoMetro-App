// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchRecordAdapter extends TypeAdapter<SearchRecord> {
  @override
  final int typeId = 10;

  @override
  SearchRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchRecord(
      id: fields[0] as String,
      query: fields[1] as String,
      hasMatch: fields[4] as bool,
      timestamp: fields[5] as DateTime,
      matchedStationId: fields[2] as String?,
      matchedStationName: fields[3] as String?,
      fromStationId: fields[6] as String?,
      fromStationName: fields[7] as String?,
      toStationId: fields[8] as String?,
      toStationName: fields[9] as String?,
      ticketPrice: fields[10] as int?,
      numStations: fields[11] as int?,
      durationMinutes: fields[12] as int?,
      routePath: (fields[13] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SearchRecord obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.query)
      ..writeByte(2)
      ..write(obj.matchedStationId)
      ..writeByte(3)
      ..write(obj.matchedStationName)
      ..writeByte(4)
      ..write(obj.hasMatch)
      ..writeByte(5)
      ..write(obj.timestamp)
      ..writeByte(6)
      ..write(obj.fromStationId)
      ..writeByte(7)
      ..write(obj.fromStationName)
      ..writeByte(8)
      ..write(obj.toStationId)
      ..writeByte(9)
      ..write(obj.toStationName)
      ..writeByte(10)
      ..write(obj.ticketPrice)
      ..writeByte(11)
      ..write(obj.numStations)
      ..writeByte(12)
      ..write(obj.durationMinutes)
      ..writeByte(13)
      ..write(obj.routePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
