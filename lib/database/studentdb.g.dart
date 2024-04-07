// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentdb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentdbAdapter extends TypeAdapter<Studentdb> {
  @override
  final int typeId = 1;

  @override
  Studentdb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Studentdb(
      studentname: fields[0] as String?,
      contact: fields[1] as String,
      place: fields[2] as String?,
      rollnumber: fields[3] as String?,
      year: fields[4] as String,
      image: fields[5] as String?,
      id: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Studentdb obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.studentname)
      ..writeByte(1)
      ..write(obj.contact)
      ..writeByte(2)
      ..write(obj.place)
      ..writeByte(3)
      ..write(obj.rollnumber)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentdbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
