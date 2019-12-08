// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarkmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookMarkModelAdapter extends TypeAdapter<BookMarkModel> {
  @override
  BookMarkModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookMarkModel(
      websiteName: fields[0] as String,
      title: fields[1] as String,
      headLine: fields[2] as String,
      url: fields[3] as String,
      urlToImage: fields[4] as String,
      publishedAt: fields[5] as String,
      content: fields[6] as String,

    );
  }

  @override
  void write(BinaryWriter writer, BookMarkModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.websiteName)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.headLine)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.urlToImage)
      ..writeByte(5)
      ..write(obj.publishedAt)
      ..writeByte(6)
      ..write(obj.content);
  }
}
