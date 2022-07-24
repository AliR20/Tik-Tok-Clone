import 'package:get/get.dart';
import 'package:tiktok_clone/const.dart';
import 'package:tiktok_clone/models/video.dart';

class VideoController extends GetxController{
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]); 
  List<Video> get videoList => _videoList.value;
  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(firestore.collection('videos').snapshots().map((query){
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(Video.fromJson(element));
      }
      return retVal;
    }));
  }
}