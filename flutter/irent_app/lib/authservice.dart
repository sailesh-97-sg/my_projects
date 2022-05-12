import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuthService {
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<String> changeProfile(uid, name, _myImage) async {
    CollectionReference updateProfile =
        FirebaseFirestore.instance.collection('users');
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("users/$uid/profile_img");
    try {
      await currentUser!.updateDisplayName(name);
      // await currentUser!.updateEmail(email);
      if (_myImage != null) {
        firebase_storage.UploadTask uploadTask =
            firebaseStorageRef.putFile(_myImage);
        firebase_storage.TaskSnapshot storageSnapshot = await uploadTask;
        var downloadUrl = await storageSnapshot.ref.getDownloadURL();
        String url = downloadUrl.toString();
        updateProfile
            .doc(uid)
            .update({
              'name': name,
              // 'email': email,
              // 'phone_number': mobileNumber,
              "profileURL": url
            })
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
      } else {
        updateProfile
            .doc(uid)
            .update({
              'name': name,
              // 'email': email,
              // 'phone_number': mobileNumber,
            })
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
      }
      // await currentUser!.updatePhoneNumber(mobileNum); For future expansion
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> changePassword(newPassword) async {
    try {
      await currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
    return "success";
  }
}
