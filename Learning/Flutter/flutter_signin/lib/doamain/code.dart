import 'dart:convert';

class Code {
  int id;
  String code;
  String title;
  String? comment;
  String? firebaseId;

  Code(
      {required this.id,
      required this.code,
      required this.title,
      this.comment,
      this.firebaseId});

  factory Code.fromMap(Map<String, dynamic> json) => Code(
        id: json['id'],
        code: json['code'],
        title: json['title'],
        comment: json['comment'],
        firebaseId: json['firebaseId'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'title': title,
        'comment': comment,
        'firebaseId': firebaseId,
      };
}
