import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String id;
  String uid;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;
  Video({
    required this.caption,
    required this.commentCount,
    required this.id,
    required this.likes,
    required this.profilePhoto,
    required this.shareCount,
    required this.songName,
    required this.thumbnail,
    required this.uid,
    required this.username,
    required this.videoUrl,
  });

  Map<String, dynamic> toJson() => {
        'caption': caption,
        'commentCount': commentCount,
        'id': id,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'shareCount': shareCount,
        'thumbail': thumbnail,
        'uid': uid,
        'username': username,
        'videoUrl': videoUrl,
      };
  factory Video.fromJson(DocumentSnapshot snapshot) {
    return Video(
      caption: snapshot['caption'],
      commentCount: snapshot['commentCount'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      shareCount: snapshot['shareCount'],
      songName: snapshot['songName'],
      thumbnail: snapshot['thumbnail'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      videoUrl: snapshot['videoUrl'],
    );
  }
}
