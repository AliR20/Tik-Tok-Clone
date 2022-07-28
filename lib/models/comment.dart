import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username, comment, uid, id, profilePhoto;
  final datePublished;
  List likes;
  Comment({
    required this.comment,
    required this.datePublished,
    required this.id,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.username,
  });
  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'datePublished': datePublished,
      'id': id,
      'likes': likes,
      'profilePhoto': profilePhoto,
      'uid': uid,
      'username': username,
    };
  }

  static Comment fromSnap(DocumentSnapshot docs) {
    var snapshot = docs.data() as Map<String, dynamic>;
    return Comment(
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      username: snapshot['username'],
    );
  }
}
