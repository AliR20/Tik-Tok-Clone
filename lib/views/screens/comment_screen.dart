import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/const.dart';
import 'package:timeago/timeago.dart' as tago;
import 'package:tiktok_clone/controllers/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({Key? key, required this.id}) : super(key: key);
  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.postComment(id);
    return Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(child: Obx(() {
              return ListView.builder(
                  itemCount: commentController.comments.length,
                  itemBuilder: (context, int index) {
                    final comment =commentController.comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(comment.profilePhoto),
                      ),
                      title: Row(
                        children: [
                          Text(
                            '${comment.username} ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            comment.comment,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            tago.format(comment.datePublished.toDate()),
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${comment.likes.length} likes',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      trailing: InkWell(
                          onTap: () => commentController.likeComment(comment.id),
                          child: Icon(
                            Icons.favorite,
                            size: 25,
                            color: comment.likes.contains(authController.user.uid)?  Colors.red: Colors.white,
                          )),
                    );
                  });
            })),
            Divider(),
            ListTile(
              title: TextFormField(
                controller: _commentController,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Comment',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ),
              trailing: TextButton(
                child: Text(
                  'Send',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                onPressed: ()=> commentController.postComment(_commentController.text),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
