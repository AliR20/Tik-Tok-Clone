import 'package:get/get.dart';
import 'package:tiktok_clone/const.dart';
import 'package:tiktok_clone/models/users.dart';

class SearchController extends GetxController{
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);
  List<User> get searchedUsers => _searchedUsers.value;
  
  searchUser(String typedUser)async{
_searchedUsers.bindStream(firestore.collection('users').where('name',isGreaterThanOrEqualTo: typedUser,).snapshots().map((query){
  List<User> retVal = [];
  for (var element in query.docs) {
     retVal.add(User.fromSnap(element));
  }
  return retVal;
}));
  }

}