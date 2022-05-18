import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 0)
class Comment {
  @HiveField(0)
  int? postId;
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? body;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Comment(
      {this.postId,
        this.id,
        this.name,
        this.email,
        this.body});
}
