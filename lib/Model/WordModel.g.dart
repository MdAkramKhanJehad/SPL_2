// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WordModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordModelAdapter extends TypeAdapter<WordModel> {
  @override
  final typeId = 0;

  @override
  WordModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordModel(
      word: fields[0] as String,
      definition: fields[1] as String,
      example: fields[2] as String,
      partsOfSpeech: fields[3] as String,
      isFavourite: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.definition)
      ..writeByte(2)
      ..write(obj.example)
      ..writeByte(3)
      ..write(obj.partsOfSpeech)
      ..writeByte(4)
      ..write(obj.isFavourite);
  }
}
