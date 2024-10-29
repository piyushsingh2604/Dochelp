import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileWidget extends StatefulWidget {
  String name;
  String gmail;
  EditProfileWidget({super.key, required this.name, required this.gmail});
  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _experienceController =
      TextEditingController(); // New controller for Experience
  final TextEditingController _chargePerHourController =
      TextEditingController(); // New controller for Charge Per Hour

  late String userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        _nameController.text = data?['name'] ?? '';
        _numberController.text = data?['number'] ?? '';
        _locationController.text = data?['location'] ?? '';
        _professionController.text = data?['profession'] ?? '';
        _experienceController.text =
            data?['experience'] ?? ''; // Fetch experience
        _chargePerHourController.text =
            data?['charge_per_hour']?.toString() ?? ''; // Fetch charge per hour
      } else {
        print("User profile does not exist.");
      }
    } catch (e) {
      print("Error fetching user profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch profile: $e')),
      );
    }
  }

  Future<void> _saveProfile() async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();
      Map<String, dynamic> existingData =
          snapshot.data() as Map<String, dynamic>;

      Map<String, dynamic> newData = {
        'name': _nameController.text.isNotEmpty
            ? _nameController.text
            : existingData['name'],
        'number': _numberController.text.isNotEmpty
            ? _numberController.text
            : existingData['number'],
        'location': _locationController.text.isNotEmpty
            ? _locationController.text
            : existingData['location'],
        'profession': _professionController.text.isNotEmpty
            ? _professionController.text
            : existingData['profession'],
        'experience': _experienceController.text.isNotEmpty
            ? _experienceController.text
            : existingData['experience'], // Save experience
        'charge_per_hour': _chargePerHourController.text.isNotEmpty
            ? double.tryParse(_chargePerHourController.text)
            : existingData['charge_per_hour'], // Save charge per hour
      };

      await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .set(newData, SetOptions(merge: true));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile: $e')),
      );
    }
  }

  File? _image;
  String? _imageUrl;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('Picked image: ${pickedFile.path}');
      User? user = FirebaseAuth.instance.currentUser;
      String? oldImageUrl;

      // Fetch the old image URL from Firestore
      if (user != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();
        var data = doc.data() as Map<String, dynamic>?;

        if (data != null &&
            data['images'] is List &&
            data['images'].isNotEmpty) {
          oldImageUrl = data['images'][0]; // Get the old image URL
        }
      }

      setState(() {
        _image = File(pickedFile.path);
        _imageUrl = pickedFile.path; // Save the path of the selected image
      });

      await _uploadImage(_image!, oldImageUrl);
    } else {
      print('No image selected');
    }
  }

  Future<void> _uploadImage(File image, String? oldImageUrl) async {
    try {
      // Delete the old image from Firebase Storage
      if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
        Reference oldImageRef =
            FirebaseStorage.instance.refFromURL(oldImageUrl);
        await oldImageRef.delete();
        print('Deleted old image: $oldImageUrl');
      }

      // Upload the new image
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);

      // Await the upload completion and get the download URL
      String downloadURL = await (await uploadTask).ref.getDownloadURL();
      print('Uploaded new image: $downloadURL');

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update the user's document with the new image URL
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .update({
          'images': [downloadURL], // Store only the new image URL
          'updated_at': Timestamp.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Uploaded! URL: $downloadURL')),
        );
      }
    } catch (e) {
      print('Upload failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                    color: const Color.fromARGB(29, 158, 158, 158),
                    thickness: 4),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 125,
                      child: Stack(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent[100],
                              image: _imageUrl != null
                                  ? DecorationImage(
                                      image: FileImage(File(_imageUrl!)),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image:
                                          AssetImage('path_to_default_image'),
                                      fit: BoxFit
                                          .cover), // Change to your default image path
                              borderRadius: BorderRadius.circular(120),
                            ),
                          ),
                          Positioned(
                            top: 75,
                            right: 2,
                            child: InkWell(
                              onTap: _pickImage,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(55),
                                  color: Color(0xFF27B4E4),
                                ),
                                child: Center(
                                  child: Icon(Icons.camera_alt_outlined,
                                      color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Gap(30),
                _buildLabel("Name", widget.name),
                _buildLabel("Email Address", widget.gmail),

                _buildTextField("User Name", _nameController, null),
                _buildTextField("Number", _numberController,
                    Icons.perm_contact_cal_outlined),
                _buildTextField("Store Address", _locationController, null),
                _buildTextField("Profession", _professionController, null),
                _buildTextField("Experience", _experienceController,
                    null), // New Experience Field
                _buildTextField("Charge Per Hour", _chargePerHourController,
                    null), // New Charge Per Hour Field

                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: InkWell(
                    onTap: _saveProfile,
                    child: Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xFF27B4E4),
                      ),
                      child: Center(
                        child: Text(
                          "SAVE PROFILE",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(subtitle,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData? suffixIcon) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF27B4E4),
                  fontWeight: FontWeight.w600)),
          TextFormField(
            controller: controller,
            cursorHeight: 20,
            decoration: InputDecoration(
              suffixIcon: suffixIcon != null
                  ? Icon(suffixIcon, color: Colors.grey)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
