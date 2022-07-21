import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/const.dart';
import 'package:tiktok_clone/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
   pickVideo(ImageSource src,BuildContext context)async {
    final video = await ImagePicker().pickVideo(source: src);
    if(video != null){
    Navigator.of(context).push(MaterialPageRoute(builder:((context) => ConfirmScreen(videoFile: File(video.path),videoPath: video.path,))));
    }
   }
  showOptionsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: Row(children: [
                    Icon(Icons.image),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('Gallery',style: TextStyle(fontSize: 20),),
                    ),
                  ],),
                ),
                 SimpleDialogOption(
                  onPressed: ()=> pickVideo(ImageSource.camera, context),
                  child: Row(children: [
                    Icon(Icons.camera_alt),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('Camera',style: TextStyle(fontSize: 20),),
                    ),
                  ],),
                ),
                 SimpleDialogOption(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Row(children: [
                    Icon(Icons.cancel),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('Cancel',style: TextStyle(fontSize: 20),),
                    ),
                  ],),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgrounColor,
      body: Center(
          child: InkWell(
              onTap: () => showOptionsDialog(context),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 190,
                decoration: BoxDecoration(color: buttonColor),
                child: Text(
                  'Add Video',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ))),
    );
  }
}
