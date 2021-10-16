import 'package:hive/hive.dart';
import 'package:shopping/model/item_model.dart';

class CartAdapter extends TypeAdapter<ItemModel> {
  @override
  ItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemModel(
      id: fields[0],
      title: fields[1],
      price: fields[2],
      description: fields[3],
      category: fields[4],
      image: fields[5],
      rating: fields[6],
    );
  }

  @override
  final int typeId = 1;

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.rating);
  }
}

class RatingAdapter extends TypeAdapter<Rating> {
  @override
  Rating read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rating(
      rate: fields[0],
      count: fields[0],
    );
  }

  @override
  final int typeId = 2;

  @override
  void write(BinaryWriter writer, Rating obj) {
    writer
      ..writeByte(0)
      ..write(obj.rate)
      ..writeByte(1)
      ..write(obj.count);
  }
}

