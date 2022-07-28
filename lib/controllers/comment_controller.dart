import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/const.dart';
import 'package:tiktok_clone/models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = '';
  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(firestore
        .collection('vidoes')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((query) {
      List<Comment> retVal = [];
      for (var comment in query.docs) {
        retVal.add(Comment.fromSnap(comment));
      }
      return retVal;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user.uid)
            .get();
        var allDocs = await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDocs.docs.length;
        Comment comment = Comment(
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          id: 'Comment $len',
          likes: [],
          profilePhoto: (userDoc.data() as dynamic)['profilePhoto'],
          uid: authController.user.uid,
          username: (userDoc.data() as dynamic)['username'],
        );
        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(comment.toJson());
        DocumentSnapshot doc =
            await firestore.collection('videos').doc(_postId).get();
        firestore.collection('videos').doc(_postId).update({
          'commentCount': (doc.data as dynamic)['commentCount'] + 1,
        });
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error whilte Commenting', e.message!);
    }
   
    
  }
   likeComment(String id) async {
      var uid = authController.user.uid;
      DocumentSnapshot doc = await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .get();
          if((doc.data() as dynamic)['likes'].contains(uid)){
           await  firestore.collection('videos').doc(_postId).collection('comments').doc(id).update({
              'likes': FieldValue.arrayRemove([uid])

            });
          }else{
            await firestore.collection('videos').doc(_postId).collection('comments').doc(id).update({
              'likes': FieldValue.arrayUnion([uid])

            });
          }}
}
