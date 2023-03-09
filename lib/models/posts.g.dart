// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostsAdapter extends TypeAdapter<Posts> {
  @override
  final typeId = 0;

  @override
  Posts read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Posts(
      title: fields[0] as String?,
      content: fields[1] as String?,
      date: fields[2] as String?,
      author: fields[3] as String?,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Posts obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.image);
  }
}
