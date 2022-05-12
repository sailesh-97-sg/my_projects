import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

String? uid = FirebaseAuth.instance.currentUser?.uid;

// Stream<QuerySnapshot> getUserInfo() {
//   return FirebaseFirestore.instance.collection("users").doc(uid).snapshots();
// }

Future selectImage() async {
  final image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxHeight: 1500,
    maxWidth: 1500,
  );
  if (image != null) {
    return File(image.path);
  }
  return null;
}

Future uploadProfileImage(_myImage) async {
  final firebase_storage.Reference firebaseStorageRef = firebase_storage
      .FirebaseStorage.instance
      .ref()
      .child("users/$uid/profile_img"); //i is the name of the image
  firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(_myImage);
  try {
    firebase_storage.TaskSnapshot storageSnapshot = await uploadTask;
    var downloadUrl = await storageSnapshot.ref.getDownloadURL();
    final String url = downloadUrl.toString();
    //You might want to set this as the _auth.currentUser().photourl

  } on FirebaseException catch (e) {
    print(uploadTask.snapshot);
  }
}

Future<String> getProfileImage() async {
  final firebase_storage.Reference firebaseStorageRef = firebase_storage
      .FirebaseStorage.instance
      .ref()
      .child("users/$uid/profile_img"); //i is the name of the image
  try {
    var downloadUrl = await firebaseStorageRef.getDownloadURL();
    return (downloadUrl);
  } on FirebaseException catch (e) {
    return "";
  }
}

Future<String> getProfileName() async {
  final firebase_storage.Reference firebaseStorageRef = firebase_storage
      .FirebaseStorage.instance
      .ref()
      .child("users/$uid/profile_img"); //i is the name of the image
  try {
    var downloadUrl = await firebaseStorageRef.getDownloadURL();
    return (downloadUrl);
  } on FirebaseException catch (e) {
    return "";
  }
}
