import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/const.dart';
import 'package:video_compress/video_compress.dart';

import '../models/video.dart';

class UploadVideoController extends GetxController {
  compressVideo(String videpPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videpPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  uploadToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('Videos').child(id);
    UploadTask uploadTask = ref.putFile(await compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  getThumbail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('Thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await getThumbail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String caption, String songName, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      var videoUrl = await uploadToStorage('Video $len', videoPath);
      var thumbnail = await uploadImageToStorage('Video $len', videoPath);
      Video video = Video(
          caption: caption,
          commentCount: 0,
          id: 'Video $len ',
          likes: [],
          profilePhoto: userDoc['profilePhoto'],
          shareCount: 0,
          songName: songName,
          thumbnail: thumbnail,
          uid: uid,
          username: userDoc['name'],
          videoUrl: videoUrl);
          await firestore.collection('videos').doc('Video $len').set(video.toJson());
          Get.back();
    } catch (e) {
      print(e);
      Get.snackbar('Error Uploading Video', e.toString());
    }
  }
}
