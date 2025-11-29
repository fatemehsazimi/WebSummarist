// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urls_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UrlsModelAdapter extends TypeAdapter<UrlsModel> {
  @override
  final int typeId = 0;

  @override
  UrlsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UrlsModel(
      url: fields[0] as String,
      summaryresult: fields[1] as String,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UrlsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.summaryresult)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UrlsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
