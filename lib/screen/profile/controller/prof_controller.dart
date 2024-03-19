import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString imageUrl = RxString('');
  late User? user;

  @override
  void onInit() {
    super.onInit();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      fetchUserData();
    }
  }

  Future<void> pickAndUploadImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        print('Picked file path: ${pickedFile.path}');
        String imageUrl = await uploadImage(File(pickedFile.path), user!.uid);
        print('Uploaded image URL: $imageUrl');
        await updateProfileImage(user!.uid, imageUrl);
        print('Profile image updated successfully');
      }
    } catch (e) {
      print('Error picking and uploading image: $e');
    }
  }

  Future<void> fetchUserData() async {
    try {
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection('email_users')
                .doc(user!.uid)
                .get();

        if (userData.exists) {
          Map<String, dynamic> data = userData.data()!;
          name.value = data['firstName'] ?? '';
          email.value = data['email'] ?? '';
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<String> uploadImage(File imageFile, String userId) async {
    try {
      String fileName =
          'profile_images/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      await firebaseStorageRef.putFile(imageFile);
      return await firebaseStorageRef.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<void> updateProfileImage(String userId, String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('email_users')
          .doc(userId)
          .update({'image': imageUrl});
      this.imageUrl.value = imageUrl; // Update the local state
    } catch (e) {
      print('Error updating profile image URL: $e');
    }
  }
}
