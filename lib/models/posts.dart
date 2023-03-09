import 'package:hive/hive.dart';

part 'posts.g.dart';

@HiveType(typeId: 0)
class Posts {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? content;

  @HiveField(2)
  final String? date;

  @HiveField(3)
  final String? author;

  @HiveField(4)
  final String? image;
  Posts({
    this.title,
    this.content,
    this.date,
    this.author,
    this.image,
  });
}
