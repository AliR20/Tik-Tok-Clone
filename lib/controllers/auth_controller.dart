import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/const.dart';
import 'package:tiktok_clone/models/users.dart' as model;
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
   late Rx<File?> _image;
   late Rx<User?> _user;
   User get user => _user.value!;
   @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, setInitialScreen);
  }
  setInitialScreen(User? user){
    if(user == null){
      Get.offAll(() => LoginScreen());
    }else{
      Get.offAll(() => HomeScreen());
    }
  }
   File? get profilePhoto => _image.value;
  void pickImage()async{
    var pickedImage =  await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      Get.snackbar('Profile Photo', 'You have successfully selected your profile photo');
       
    _image = Rx<File?>(File(pickedImage.path));
    }else{
      Get.snackbar('No Image Selected', 'Please select an image');
    }
  }
  //Saving profile Picture in Storage
  Future<String> uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('ProfilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //Registering Users
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await uploadToStorage(image);
        model.User user = model.User(name: username, email: email, profilePhoto: downloadUrl, uid: cred.user!.uid);
       await  firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

      }else{
        Get.snackbar('Error Creating Account','Please enter all the fields');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Creating Account', e.message!);
    }
  }
  //Logging User
  void loginUser(String email,String password)async{
    try{
      if(email.isNotEmpty && password.isNotEmpty){
await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      }else{
        Get.snackbar('Error Loggin in', 'Please Enter all fields');
      }
    } on FirebaseAuthException catch(e){
      Get.snackbar('Error Loggin in', e.message!);
    }
    
  }
  void signOut()async{
    await firebaseAuth.signOut();
  }
}
